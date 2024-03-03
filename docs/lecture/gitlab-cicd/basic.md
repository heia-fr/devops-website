---
title: Création d'une image Docker
---

## Commençons avec un programme simple

Pour illustrer ce chapitre, commençons par un programme en Go qui affiche
un message de bienvenue, ainsi que quelques informations sur votre système.

Créez un nouveau dossier et ajoutez-y ces deux fichiers "go.mod" et "hello-devops.go" :

``` text title="go.mod"
module hello-devops

go 1.22.0
```

``` Go title="hello-devops.go"
package main

import (
        "fmt"
        "runtime"
)

func main() {
        fmt.Println("Hello DevOps!")
        fmt.Println("Go version:", runtime.Version())
        fmt.Println("Architecture:", runtime.GOARCH)
        fmt.Println("OS:", runtime.GOOS)
}
```

Pour vérifier que tout fonctionne correctement, vous pouvez compiler ces programmes
sur votre machine. Si ce n'est pas encore fait, [téléchargez l'environnement de développement
Go](https://go.dev/dl/) et [installez-le](https://go.dev/doc/install) sur votre machine.

Tapez maintenant la commande suivante dans un terminal :

``` bash
go run .
```

et vous devriez obtenir quelque chose qui ressemble à ça :

``` text
Hello DevOps!
Go version: go1.22.0
Architecture: amd64 (ou arm64)
OS: windows (ou linux, ou darwin)
```

Bravo! Vous avez écrit un programme en Go!

## Containairisation du programme

Mais si vous n'aviez pas envie (ou si vous ne pouviez pas) installer l'environnement
de développement Go, vous auriez aussi pu exécuter ce programme en passant par une
image Docker. C'est ce que nous allons faire maintenant.

Créez un fichier "Dockerfile" dans le même dossier :

``` Dockerfile title="Dockerfile"
FROM golang:1.22 AS builder
WORKDIR /app
COPY go.mod hello-devops.go ./
RUN go build .

FROM alpine:3.19
WORKDIR /root/
COPY --from=builder /app/hello-devops /usr/local/bin/hello-devops
CMD ["/usr/local/bin/hello-devops"]
```

!!! warning "Attention"
    Dans le `Dockerfile` ci-dessus, nous téléchargeons les images du "registry" DockerHub.
    En principe, les images téléchargées depuis DockerHub sont sauvées dans un cache local
    et on ne devrait pas avoir de problème avec la [limite de
    100 téléchargements](https://docs.docker.com/docker-hub/download-rate-limit/#whats-the-download-rate-limit-on-docker-hub)
    que nous impose Docker.
    
    Notez que pour contourner cette limite, vous pouvez aussi utiliser d'autres "registry"
    comme le [Public Elastic Container Registry d'Amazone](https://gallery.ecr.aws/).

construisez une image Docker :

``` bash
docker build -t hello-devops .
```

et exécutez-la :

``` bash
docker run --rm hello-devops
```

Vous obtenez quelque chose comme ça :

``` text
Hello DevOps!
Go version: go1.22.0
Architecture: arm64
OS: linux
```

l'architecture est la même que votre machine (amd64 ou arm64), mais l'OS est
maintenant "linux", car le container fonctionne bien dans un environnement Linux.

## Utilisation du CI/CD

Jusqu'ici, nous avons fait toutes les opérations sur
notre ordinateur personnel. Il est temps de passer au CI/CD
et laisser les ordinateurs du _cloud_ faire le travail.

Ajoutez le fichier ".gitlab-ci.yml" à votre dossier :

``` yaml title=".gitlab-ci.yml"
image: docker:25.0

services:
  - docker:25.0-dind

variables:
  IMAGE_TAG_SLUG: $CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG
  IMAGE_TAG_LATEST: $CI_REGISTRY_IMAGE:latest

before_script:
  - docker info

build:
  stage: build
  script:
    - docker build -t $IMAGE_TAG_LATEST .
    - docker tag $IMAGE_TAG_LATEST $IMAGE_TAG_SLUG
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker push $IMAGE_TAG_SLUG
    - docker push $IMAGE_TAG_LATEST
```

!!! note "Note"
    le service `docker:25.0-dind` (dind = Docker-in-Docker) permet de faire
    tourner du Docker dans du Docker.

    Le Service Informatique recommande l'utilisation de [Kaniko](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html)
    pour la création d'image Docker. Cependant, Kaniko n'est pas encore capable
    de faire des images multi-architectures et c'est pourquoi nous ne l'utilisons
    pas ici. La [documentation](https://docs.gitlab.com/ee/ci/docker/using_kaniko.html#build-a-multi-arch-image)
    fait mention d'un "manifest-tool" pour construire les images multi-architectures, mais
    je trouve que c'est un peu compliqué et je préfère la méthode que je vais vous
    montrer dans le chapitre suivant.

Avec ce fichier, vous indiquez à GitLab ce qu'il doit faire quand une nouvelle
version est _poussée_ (push) dans le dépôt.

Si ce n'est pas déjà fait, créez un dépôt dans le GitLab de l'école et mettez-y
tous les fichiers que vous venez de créer.

Après avoir synchronisé votre dépôt (avec `git push`), vous devriez voir une nouvelle
entrée dans la section "CI/CD" --> "Pipelines" :

<figure markdown>
![](img/cicd0.webp){: width="650" }
</figure>

Vous devriez aussi avoir une entrée dans "Deploy" --> "Container registry".

<figure markdown>
![](img/cicd1.jpg)
</figure>

Vous pouvez télécharger et exécuter cette image avec la commande :

``` bash
docker run --rm registry.forge.hefr.ch/<NAMESPACE>/<REPOSITORY>
```

!!! info "Info"
    Si votre projet est privé, vous devrez probablement vous authentifier avant
    de pouvoir utiliser l'image :

    ```bash
    docker login registry.forge.hefr.ch
    ```

et vous devriez obtenir ceci :

``` text
Hello DevOps!
Go version: go1.22.0
Architecture: amd64
OS: linux
```

L'architecture sera toujours _amd64_ car le _runner_ qui a compilé votre
programme dans GitLab est une machine avec une architecture _amd64_
et si vous faites tourner cette image sur un Mac récent (avec une puce ARM),
vous observerez le message suivant:

``` text
WARNING: The requested image's platform (linux/amd64) does not match
the detected host platform (linux/arm64/v8) and no specific platform
was requested
```