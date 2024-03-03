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
      - 'main'
    tags:
      - 'v*'
  pull_request:
    branches:
      - 'main'

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  buildx:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
      - name: Login to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - name: Docker meta
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
      - name: Build and push
        uses: docker/build-push-action@v4
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

Consultez les pages suivantes pour les explications :

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Publishing images to GitHub Packages](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images#publishing-images-to-github-packages)
- [GitHub Action to login against a Docker registry](https://github.com/docker/login-action)
- [GitHub Action to extract metadata](https://github.com/docker/metadata-action)
- [GitHub Action to build and push Docker images with Buildx](https://github.com/docker/build-push-action)
