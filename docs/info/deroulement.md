---
title: Déroulement général - Dates clés
---

# {{ title }}

Le tableau suivant résume les étapes principales du projet et fixe les
échéances qui doivent impérativement être respectées. Ce calendrier ne
constitue pas un planning détaillé de développement, adapté à chaque
groupe. En effet, l'élaboration d'un planning de développement détaillé
fait partie du travail à réaliser au sein de chaque groupe.

!!! warning "Attention"
    - **Par défaut**, les délais des livrables sont fixés au **mercredi précédent le prochain cours avec le (ou la) prof responsable du livrable, à 18h**.
    - A chaque soumission, il faut **notifier** le ou la prof. concerné(e) dans le canal Teams du groupe (avec un tag). Le dernier commit réalisé avant le délai sur la branche principale fera foi. 
    - Il revient au groupe de solliciter les professeurs concernés par le rendu pour demander une validation des propositions, afin de pouvoir avancer.

## P1 : Mardi / Jeudi

### Mardi 17.02 à 8h15
- Introduction au projet SpotOn, installations (Eden Brenot)

### Jeudi 19.02 à 9h05
- Organisation du cours, but du projet (tous les profs.)

!!! note "Livrables"
    - Annonces des groupes formés (création des canaux Teams)/
    - Fork du projet et accès approprié aux profs et assistants.

## P2: Jeudi
### Jeudi 26.02 à 9h05
- Intégration et Déploiement continu CI/CD (J.Supcik)

!!! note "Livrables"
    - Propositions CI/CD
    - **En fin de projet**: configuration CI/CD pour GitLab (ou GitHub Actions)

## P3: Mardi
### Mardi 03.03 à 8h15
- DevOps and DevOps Advanced, c'est quoi ?
- Tooling (S. Rumley)

- Fin de la théorie du tooling
- Robustesse du code
- Philosophie du DevOps
- Exigences de qualité du code

On verra ce qu'on arrive à couvrir sans être trop crevés...

!!! note "Livrables"
   - Intégration initiale de SonarQube dans le projet
   - pour la semaine suivante: rapport d'analyse de l'application selon les [consignes](rapport-audit)
   - **En fin de projet**: SonarQube est utilisé pour monitorer la qualité des parties principales du code et la mesure de la couverture des tests.


## P4 : Jeudi
### Jeudi 12.03 à 10h15
- Sécurité dans un CI/CD pipeline? (M. Mäder)
- DevSecOps ?
- DevSecOps / SSDLC, c'est quoi ?
- Hands-on et exercices sur une application *mal* programmée
    - Where to put these *freaky* credentials?

!!! note "Livrables"
    - Small Threat Model of the SooZ App
    - Pipeline qui exécute un DAST


## P5 : Jeudi
### Jeudi 19.03 à 9h05
-  Testing: approches, types, et technologies (S. Ingram) 

!!! note "Livrables Testing"
    - Quatre à cinq propositions de tests cases **par écrit** à soumettre jusqu'au **6 avril** avec les technologies vues en classe (sinon.js, cypress) pour les tests frontend.
    - Chaque groupe prend contact avec le prof. pour discuter via Teams ou à distance (avant jeudi) de la proposition, en envoyant au préalable le document.
    
    - Dans la mesure du possible, tenter de spécifier de quels types de tests il s'agit (unitaires, d'intégration, tests end to end) et le type de doublons, quitte à le revisiter, le justifier, et le finaliser pour le rapport final.
    - Ne pas hésiter à mettre dans le draft de tests cases soumis, tout vos questionnements et doutes liés aux types de test etc.

    - **En fin de projet**: il est possible de lancer des tests, la CI lance des tests, la couverture des tests est mesurée. SonarQube monitore cette couverture.

    <!-- Les Technologies de test: Cypress (pour les tests UI automatisés), qui intègre [Sinon.js](https://docs.cypress.io/api/utilities/sinon) pour les doublons de tests et [Chai](https://docs.cypress.io/guides/references/assertions) pour les "assertions". --!>

## P6 : Jeudi
### Jeudi 26.03 à 10h15
- MLOps (B. Wolf)

!!! note "Livrables MLOps"
    - Petit document avec une proposition d'integration de "Machine learning".
    - Ceci inclus la structure générale/architecture de la partie MLOps du projet.
    - Rendu 13.4 13:00

## P7 : Jeudi
### Jeudi 02.04 à 10h15
- Revue des propositions DevSecOps /Q&A (M. Mäder)

## P8 : Mardi & Jeudi 
### Mardi 14.04 à 10h15
- Présentation des approches MLOps par groupe (10 minutes + discussion) (B. Wolf)
- Presentation simple, objectif principal discussion et partage de connaissances
### Jeudi 16.04 à 9h05
- Revue des propositions CI/CD (J. Supcik)

## P9 : Jeudi
### Jeudi 23.04 à 9h05
- Présentation des tests proposés par chaque groupe (S. Ingram)

## P2 - P12
- Conception, implémentation incrémentale des propositions validées
- Les profs se réservent le droit de vous convoquer pour des
  présentations dans le courant de cette période

!!! note "Livrables"
    - Reporting hebdomadaire
    - Commits "propres" et réguliers
    - PVs, et journaux de travail à jour

## P12
- Défenses orales individuelles: **jeudi 21 mai 2026 dés 9h05**
- Feedback

!!! note "Livrables"
    - Rapport final - doit être rendu au plus tard le **dimanche 17 mai 2026 à 23h59**
    - Code final sur branche "main" en même temps
