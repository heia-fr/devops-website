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

## P1 : Lundi et Jeudi

### Lundi 19.02 à 10h15

- Introduction: DevOps, c'est quoi ?
- Introduction du Projet

### Jeudi 22.02 à 8h30

- Exigences de qualité du code (S. Rumley)

!!! note "Livrables"
    - Annonces des groupes formés (canal Teams)
    - Fork du projet et accès aux profs en maintainer.

## P2: Lundi

### Lundi 26.02 à 13h

- Tooling (S. Rumley)

!!! note "Livrables"
    - Synthèse de pré-analyse de l'application

## P3: Lundi et Jeudi

### Lundi 04.03 à (attention horaire particulier) 15h

- Robustesse du code (S. Rumley)

!!! note "Livrable"
    - Pour le 15 mars : 
        - Intégration initiale de SonarQube dans le projet
        - Rapport d'analyse de l'application. Quelles sont vos recommandations, niveau qualité du code, hygiène, etc ?
    - en fin de projet : SonarQube est utilisé pour monitorer la qualité des parties principales du code

### Jeudi 07.03 à 10h15

- Intégration et Déploiement continu CI/CD (J.Supcik)

!!! note "Livrables"
    - Propositions CI/CD
    - en fin de projet: configuration CI/CD pour GitLab (ou GitHub Actions)

## P4 : Lundi et Jeudi

### Lundi 11.03 à 13h

- Philosophie DevOps (S. Rumley)

### Jeudi 14.03 à 08h15

- Sécurité dans un CI/CD pipeline? (M. Mäder)
- DevSecOps ?
- DevSecOps / SSDLC, c'est quoi ?
- Hands-on et exercices sur une application *mal* programmée

!!! note "Livrables"
    - Small Threat Model of the SooZ App
    - Pipeline qui exécute un DAST

## P5 : Lundi et Jeudi

### Lundi 18.03 ATTENTION HORAIRE particulier à 10h

- "Testing Theory" (S. Rumley)

!!! note "Livrables"
    - En fin de projet : il est possible de lancer des tests, la CI lance
      des tests, la couverture des tests est mesurée. SonarQube monitore
      cette couverture.

### Jeudi 21.03 à 10h15
-  Testing: approches, types, et technologies (S. Ingram) 

!!! note "Livrables"
    - 3 à 4 propositions de tests cases **par écrit** à soumettre jusqu'au 28.03 
    - Chaque groupe prend contact avec la prof. pour discuter via Teams ou à distance (avant jeudi) de la proposition, en envoyant au préalable le document.
    - Technologies de test: Cypress (pour les tests UI automatisés), qui intègre [Sinon.js](https://docs.cypress.io/api/utilities/sinon) pour les doublons de tests et [Chai](https://docs.cypress.io/guides/references/assertions) pour les "assertions".
    - Dans la mesure du possible, tenter de spécifier de quels types de tests il s'agit (unitaires, d'intégration, tests end to end) et le type de doublons, quitte à le revisiter, le justifier, et le finaliser pour le rapport final.
    - Ne pas hésiter à mettre dans le draft de tests cases soumis, tout vos questionnements et doutes liés aux types de test etc.
    - Implémentation des tests (entre P2 et P11).
    

## P6 : Lundi et Jeudi

### Lundi 25.03 à 10h15

- MLOps Théorie (B. Wolf)

### Jeudi 28.03 à 10h15

- MLOps (B. Wolf)

!!! note "Livrables"
    - Proposition aspect "Machine learning"
    - Structure générale MLOps.
    - Propositions MLOps

!!! note "Livrables"
    - Proposition aspect "Machine learning"
    - Propositions MLOps

## P8 : Lundi 08.04 à 13h

**Travail Ecrit** (S. Rumley)


## P9 : Jeudi 25.04 à 10h15

- Présentation des approches MLOps par groupe (10 minutes + discussion)
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

- Défenses orales individuelles: Le jeudi 23 mai de 9h à 12h30.
- Feedback

!!! note "Livrables"
    - Évaluation du module
