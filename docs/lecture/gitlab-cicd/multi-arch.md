---
title: Image multi-architectures
---

![](img/arm.webp)

## Il n'y a pas que des puces Intel dans les ordinateurs

Aujourd'hui, nous ne pouvons pas ignorer les ordinateurs avec des
architectures autres que _amd64_ (Intel). Le Raspberry Pi est
un mini-ordinateur très populaire et il fonctionne avec un microprocesseur
ARM. Tous les nouveaux Macbooks sont maintenant livrés avec un
processeur basé sur la technologie ARM. Bien que ces Macs peuvent
faire tourner des images Docker faites pour _amd64_ grâce à un
émulateur, ça reste une solution peu performante.

Nous allons donc modifier notre projet pour que le _runner_ produise
également une image ARM.

Modifiez le fichier ".gitlab-ci.yml" avec ce contenu:

``` yaml title=".gitlab-ci.yml"
image: docker:25.0

services:
  - docker:25.0-dind

variables:
  IMAGE_TAG_SLUG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
  IMAGE_TAG_LATEST: $CI_REGISTRY_IMAGE:latest
  DOCKER_CLI_EXPERIMENTAL: enabled

before_script:
  - docker info
  - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY

build:
  stage: build
  script:
    - docker buildx ls
    # Build tagged images for various architectures
    - docker buildx build --push --platform linux/amd64  --tag "${IMAGE_TAG_SLUG}-amd64" .
    - docker buildx build --push --platform linux/arm64  --tag "${IMAGE_TAG_SLUG}-arm64" .
    - docker buildx build --push --platform linux/arm/v7 --tag "${IMAGE_TAG_SLUG}-armv7" .
    - docker manifest create ${IMAGE_TAG_SLUG} "${IMAGE_TAG_SLUG}-amd64" "${IMAGE_TAG_SLUG}-arm64" "${IMAGE_TAG_SLUG}-armv7"
    - docker manifest push ${IMAGE_TAG_SLUG}
    # Build latest images for various architectures
    - docker buildx build --push --platform linux/amd64  --tag "${IMAGE_TAG_LATEST}-amd64" .
    - docker buildx build --push --platform linux/arm64  --tag "${IMAGE_TAG_LATEST}-arm64" .
    - docker buildx build --push --platform linux/arm/v7 --tag "${IMAGE_TAG_LATEST}-armv7" .
    - docker manifest create ${IMAGE_TAG_LATEST} "${IMAGE_TAG_LATEST}-amd64" "${IMAGE_TAG_LATEST}-arm64" "${IMAGE_TAG_LATEST}-armv7"
    - docker manifest push ${IMAGE_TAG_LATEST}
```

Faites un _commit_ puis in _push_ et observez le résultat dans l'interface web de GitHub. Notez que le _runner_
prend plus de temps pour construire les images, car maintenant c'est lui qui doit émuler le processeur ARM.
Après environ 3 minutes le résultat devrait être disponible et vous devriez avoir 4 les 4 _tags_ suivants :

<figure markdown>
![](img/cicd2.jpg)
</figure>

Téléchargez la nouvelle image et refaites un essai :

``` bash
docker pull registry.forge.hefr.ch/<NAMESPACE>/<REPOSITORY>
docker run --rm registry.forge.hefr.ch/<NAMESPACE>/<REPOSITORY>
```

et si vous avez une machine avec un processeur ARM, vous verrez la bonne
architecture et pas de message de type _warning_ :

``` text
Hello DevOps!
Go version: go1.20.1
Architecture: arm64
OS: linux
```

## Une seule image "multi-architecture"

Dans la section précédente, nous avons construit une image _multi-architectures_
à l'aide de plusieurs images et d'un _manifest_ et c'est la méthode recommandée
pour travailler avec le _registry_ de GitLab. Mais avec un docker récent, nous
pouvons directement faire une image multi-architectures.

Pour garder une version fonctionnelle sur Gitlab, faites maintenant un nouveau 
projet avec les fichiers "Dockerfile", "go.mod" et "hello-devops.go" et
déployez ce projet sur Gitlab.

Ajoutez le fichier ".gitlab-ci.yml" suivant:

``` yaml title=".gitlab-ci.yml"
image: docker:25.0

services:
  - docker:25.0-dind

variables:
  IMAGE_TAG_SLUG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
  IMAGE_TAG_LATEST: $CI_REGISTRY_IMAGE:latest
  DOCKER_CLI_EXPERIMENTAL: enabled

before_script:
  - docker info
  - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY

build:
  stage: build
  script:
    - docker context create devops-context
    - docker context ls
    - docker buildx create --name mutliarch-builder --use devops-context
    - docker buildx ls
    - docker buildx inspect mutliarch-builder --bootstrap
    - >
      docker buildx build
      --platform linux/amd64,linux/arm64,linux/arm/v7
      --tag $IMAGE_TAG_SLUG
      --tag $IMAGE_TAG_LATEST
      --provenance false
      --push .
```

Après avoir syncronisé votre dépôt, le CI/CD construira l'image multi-architectures et la publiera
dans le _registry_ de GitLab (Deploy --> Container Registry). Mais l'interface web de
GitLab n'affiche pas les détail des architectures :

<figure markdown>
![](img/cicd3.png)
</figure>

Par contre l'image fonctionne très bien et vous pouvez l'utiliser comme dans la section précédente.

Il y a actuellement un [epic](https://gitlab.com/groups/gitlab-org/-/epics/11952) ouvert pour améliorer l'interface web de GitLab pour les images multi-architectures :

<figure markdown>
![](img/epic-11952.png)
</figure>

## Publication de l'image dans le DockerHub

Jusqu'à maintenant, nous avons publié les images dans le _registry_ de GitLab. Mais ce n'est
pas la seule option et vous pouvez publier votre image dans d'autres registries publiques tels que :

- Docker Hub
- Canister.io
- GitHub
- AWS Container Registry
- Google Container Registry

Docker Hub est le plus populaire et nous allons y publier notre image.
Précédement, vous avez déjà défini les variables `$DOCKERHUB_USER` et `$DOCKERHUB_TOKEN`
et le _token_ que vous avez généré vous donne déjà les bonnes permissions pour publier.


Remplacez le contenu du fichier ".gitlab-ci.yml" par ceci :

```yaml title=".gitlab-ci.yml"
image: docker:25.0

services:
  - docker:25.0-dind

variables:
  DOCKERHUB_PROJECT: devops
  IMAGE_TAG_SLUG: ${DOCKERHUB_USERNAME}/${DOCKERHUB_PROJECT}:${CI_COMMIT_REF_SLUG}
  IMAGE_TAG_LATEST: ${DOCKERHUB_USERNAME}/${DOCKERHUB_PROJECT}:latest
  DOCKER_CLI_EXPERIMENTAL: enabled

before_script:
  - docker info
  - docker login -u $DOCKERHUB_USER -p $DOCKERHUB_TOKEN

build:
  stage: build
  script:
    - docker context create devops-context
    - docker context ls
    - docker buildx create --name mutliarch-builder --use devops-context
    - docker buildx ls
    - docker buildx inspect mutliarch-builder --bootstrap
    - >
      docker buildx build
      --platform linux/amd64,linux/arm64,linux/arm/v7
      --tag $IMAGE_TAG_SLUG
      --tag $IMAGE_TAG_LATEST
      --push .
```

Remplacez la variable `DOCKERHUB_PROJECT` par le nom de votre repository sur Docker Hub et mettez à
jour le dépôt sur GitLab.

Dès que le _runner_ aura fait son travail, vous devriez avoir l'image multi-architectures dans votre compte
Docker Hub avec les tags et les architectures :

<figure markdown>
![](img/dockerhub2.jpg)
</figure>

L'image sur mon compte Docker Hub est publique et vous pouvez l'essayer sans autre
avec la commande suivante :

``` bash
docker run --rm supcik/devops
```
