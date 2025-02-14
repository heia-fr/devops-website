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
    Les délais des livrables sont fixés à la fin de la dernière semaine
    précisées (le dernier commit réalisé avant minuit, le dimanche de la
    semaine en question, fait foi). Il revient au groupe de solliciter
    le professeur concerné par le rendu pour demander une validation des
    propositions, afin de pouvoir avancer.

## P1 : Mardi / Mercredi / Jeudi

### Mardi 18.02 à 15h00

- Introduction: Le cours DevOps and DevOps Advanced, c'est quoi ? (all)
- Tooling (S. Rumley)

!!! note "Livrables"
    - Synthèse de pré-analyse de l'application

### Mercredi 19.02 à 13h00

- Introduction au projet SpotOn (S. Fringeli)

## P2: Mardi

### Mardi 25.02 à 13h

- Intégration et Déploiement continu CI/CD (J.Supcik)

!!! note "Livrables"
    - Propositions CI/CD
    - en fin de projet: configuration CI/CD pour GitLab (ou GitHub Actions)

## P3: Mardi

### Mardi 04.03 à 9h

- Exigences de qualité du code (S. Rumley)

!!! note "Livrables"
    - Annonces des groupes formés (canal Teams)
    - Fork du projet et accès aux profs approprié.

- Robustesse du code (S. Rumley)

!!! note "Livrable"
    - Pour le 15 mars : 
        - Intégration initiale de SonarQube dans le projet
        - Rapport d'analyse de l'application. Quelles sont vos recommandations, niveau qualité du code, hygiène, etc ?
    - en fin de projet : SonarQube est utilisé pour monitorer la qualité des parties principales du code

- Philosophie DevOps (S. Rumley)

## P4 : Mardi

### Mardi 11.03 à 9h

- Sécurité dans un CI/CD pipeline? (M. Mäder)
- DevSecOps ?
- DevSecOps / SSDLC, c'est quoi ?
- Hands-on et exercices sur une application *mal* programmée
    - Where to put these *freaky* credentials?

!!! note "Livrables"
    - Small Threat Model of the SooZ App
    - Pipeline qui exécute un DAST

## P5 : Mardi

### Mardi 18.03 à 9h

- "Testing Theory" (S. Rumley)

!!! note "Livrables"
    - En fin de projet : il est possible de lancer des tests, la CI lance
      des tests, la couverture des tests est mesurée. SonarQube monitore
      cette couverture.

## P6 : Mardi

### Mardi 25.03 à 9h

- MLOps (B. Wolf)

!!! note "Livrables"
    - Proposition aspect "Machine learning"
    - Structure générale MLOps.
    - Propositions MLOps

## P7 : Mardi

### Mardi 01.04 à 9h

-  Testing: approches, types, et technologies (S. Fringeli / S. Ingram) 

!!! note "Livrables"
    - 3 à 4 propositions de tests cases **par écrit** à soumettre jusqu'au 28.03 
    - Chaque groupe prend contact avec la prof. pour discuter via Teams ou à distance (avant jeudi) de la proposition, en envoyant au préalable le document.
    - Technologies de test: Cypress (pour les tests UI automatisés), qui intègre [Sinon.js](https://docs.cypress.io/api/utilities/sinon) pour les doublons de tests et [Chai](https://docs.cypress.io/guides/references/assertions) pour les "assertions".
    - Dans la mesure du possible, tenter de spécifier de quels types de tests il s'agit (unitaires, d'intégration, tests end to end) et le type de doublons, quitte à le revisiter, le justifier, et le finaliser pour le rapport final.
    - Ne pas hésiter à mettre dans le draft de tests cases soumis, tout vos questionnements et doutes liés aux types de test etc.
    - Implémentation des tests (entre P2 et P11).

## P8 : Mardi 08.04 à 9h

**Travail Ecrit** (S. Rumley)

## P9 : Mardi 15.04 à 9h

- Présentation des approches MLOps par groupe (10 minutes + discussion) (B. Wolf)
- Presentation simple, objectif principal discussion et partage de connaissances

## P2 - P12

- Conception, implémentation incrémentale des propositions validées
- Les profs se réservent le droit de vous convoquer pour des
  présentations dans le courant de cette période

!!! note "Livrables"
    - Reporting hebdomadaire
    - Commits "propres" et réguliers
    - PVs, et journaux de travail à jour

## P12

- Finalisation

!!! note "Livrables"
    - Rapport final
    - Code final sur branche "main"

## P13

- Défenses orales individuelles: *date to be defined*
- Feedback

!!! note "Livrables"
    - Évaluation du module
