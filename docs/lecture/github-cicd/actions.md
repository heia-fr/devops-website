---
title: Les Actions
---

# Les _Actions_

Les _github actions_ sont les mécanismes qui permettent de faire du CI/CD
avec github. Pour activer les actions, il suffit de créer un fichier _.yml_
dans un dossier `.github/workflows` à la racine de votre projet.

Par exemple 

```yaml title=".github/workflows/hello.yml" linenums="1"
name: hello-world
on: push

jobs:
  my-job:
    runs-on: ubuntu-latest
    steps:
      - name: my-step
        run: echo "Hello World!"
```

La plupart du temps, vous n'aurez pas besoin de faire vos propres _actions_
et il vous suffira d'assembler des actions existantes dans un _workflow_.