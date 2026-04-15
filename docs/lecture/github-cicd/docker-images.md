---
title: Les Images Docker
---

# Créer et publier les images Docker

Le _workflow_ suivant permet de créer et de publier une image Docker
dans le registry de github :

```yaml title=".github/workflows/build.yml" linenums="1"
{% raw %}
name: Create and publish a Docker image

on:
  workflow_dispatch:
  push:
    branches:
      - "main"
    tags:
      - "v*"
  pull_request:
    branches:
      - "main"

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  buildx:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v6
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v4
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v4
      - name: Login to GitHub Container Registry
        uses: docker/login-action@v4
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - name: Docker meta
        id: meta
        uses: docker/metadata-action@v6
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
      - name: Build and push
        uses: docker/build-push-action@v7
        with:
          context: .
          platforms: linux/amd64,linux/arm64,linux/arm/v7
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
{% endraw %}
```

Ce _workflow_ est utilisé dans le projet
[demo-devops-actions-0](https://github.com/heiafr-isc/demo-devops-actions-0)
et nous vous invitons à consulter le résultat sous l'onglet [Actions](https://github.com/heiafr-isc/demo-devops-actions-0/actions)
ainsi que dans le [Package Registry](https://github.com/heiafr-isc/demo-devops-actions-0/pkgs/container/demo-devops-actions-0)

# Le "Docker GitHub Builder"

Le _Docker GitHub Builder_ est un projet de la communauté Docker qui fournit un _workflow_ préconfiguré pour construire et publier des images Docker avec GitHub Actions.
Par rapport au _workflow_ précédent, il offre les avantages suivants :

- Il est plus simple à utiliser et à configurer.
- Il utilise les bonnes pratiques pour la construction et la publication d'images Docker.
- Il permet de construire et de publier des images multi-architecture facilement.
- Il est efficace et rapide grâce à l'utilisation de runners ARM et AMD.

Voici un exemple de _workflow_ qui utilise le _Docker GitHub Builder_ pour construire et publier une image Docker multi-architecture dans le registry de github :

```yaml title=".github/workflows/build.yml" linenums="1"
{% raw %}
name: Create and publish a Docker image

on:
  workflow_dispatch:
  push:
    branches:
      - "main"
    tags:
      - "v*"
  pull_request:
    branches:
      - "main"

jobs:
  build:
    uses: docker/github-builder/.github/workflows/build.yml@v1
    permissions:
      contents: read # to fetch the repository content
      packages: write
      id-token: write # for signing attestation(s) with GitHub OIDC Token
    with:
      output: image
      push: ${{ github.event_name != 'pull_request' }}
      platforms: linux/amd64,linux/arm64
      meta-images: |
        ghcr.io/${{ github.repository }}
      meta-tags: |
        type=ref,event=branch
        type=semver,pattern={{version}}
        type=raw,value=latest,enable={{is_default_branch}}
    secrets:
      registry-auths: |
        - registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
{% endraw %}
```

Ce _workflow_ est utilisé dans le projet
[demo-devops-actions-1](https://github.com/heiafr-isc/demo-devops-actions-1)
et nous vous invitons à consulter le résultat sous l'onglet [Actions](https://github.com/heiafr-isc/demo-devops-actions-1/actions)
ainsi que dans le [Package Registry](https://github.com/heiafr-isc/demo-devops-actions-1/pkgs/container/demo-devops-actions-1)

Consultez les pages suivantes pour les explications :

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Publishing images to GitHub Packages](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images#publishing-images-to-github-packages)
- [GitHub Action to login against a Docker registry](https://github.com/docker/login-action)
- [GitHub Action to extract metadata](https://github.com/docker/metadata-action)
- [GitHub Action to build and push Docker images with Buildx](https://github.com/docker/build-push-action)

# Le "Dependabot"

Github propose aussi un outil de gestion des dépendances appelé _Dependabot_ qui peut être utilisé pour maintenir à jour les images Docker utilisées dans votre projet.
Son utilisation est très simple et il suffit de créer le fichier `.github/dependabot.yml` avec le contenu suivant :

```yaml title=".github/dependabot.yml" linenums="1"
{% raw %}
version: 2
updates:
  - package-ecosystem: "gomod"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
{% endraw %}
```

L'exemple ci-dessus est fait pour un projet qui utilise des modules Go, des images Docker et des actions GitHub. Lisez la 
[documentation officielle](https://docs.github.com/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)
pour plus d'informations sur les options de configuration du fichier `dependabot.yml` :
