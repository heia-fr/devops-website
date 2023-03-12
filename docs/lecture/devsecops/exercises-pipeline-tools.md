---
title: Exercises and security pipeline tools
---

# {{ title }}

The main goal of these exercises is to include security tools and mechanisms into your CI/CD pipeline. For this purpose you should work on two different projects (repos). The main work will be done of the repo where the Sooze application is. A sandbox, for testing and playing is available here: https://gitlab.forge.hefr.ch/devsecops/calculatorapi (Calculator REST API)

## Question 1 - Fork the sandbox repository - the calculator REST API
Get a copy, fork it!, of this repo (https://gitlab.forge.hefr.ch/devsecops/calculatorapi), which contains a working, but very shaky pipeline. The repo and its purpose is described directly in the repo's README.md file.

Fork this repo in your group and use it to play around

## Question 2 - Analyze the existing pipeline and improve it
The existing pipeline launches some unit tests and executes also a coverage analysis of the tests. The result of the coverage test can be found in the pages section of the repository.

### SAST
How could you easily add a SAST check in the testing stage of the existing pipeline? As it is a Python environment, you should opt for `semgrep`. For Sooze application, other SAST solution (it will be covered also in the S. Rumley's lecture), like SonarQube, should be used then. 

Get some inspiration here: https://docs.gitlab.com/ee/user/application_security/sast/#configure-sast-in-your-cicd-yaml 

### DAST
Integrate in your pipeline a DAST check. Use for this the OWASP ZAP. Also here you find some inspiration on how to setup: https://docs.gitlab.com/ee/user/application_security/dast/

DAST tests your application will it is running. So, you must ensure that a version of your test application (calculator) runs during your DAST tests. For this, you must use DinD (Docker-in-Docker). On the gitlab inspiration site you find a lot of information about that. Here a snippet, how your pipeline could look like for launching the calculator application:

```bash
### build the docker image with the running application (calculator) ####
variables:
  IMAGE_TAG_SHA: "$CI_REGISTRY_IMAGE/calculator/image:$CI_COMMIT_SHORT_SHA"
  IMAGE_TAG: "$CI_REGISTRY_IMAGE/calculator/image:latest"
  
build_flask_service:
  image: docker:19.03.13    # this version is known to work smoothly with the HEIA-FR's gitlab system
  stage: build
  services:
    - docker:19.03.13-dind
  script:
    - cd src/
    - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
    - docker pull $IMAGE_TAG || true
    - docker build --network host --cache-from $IMAGE_TAG -t $IMAGE_TAG_SHA -t $IMAGE_TAG .
    - docker push $IMAGE_TAG_SHA
    - docker push $IMAGE_TAG
  before_script:
    - docker info
    - echo $IMAGE_TAG_SHA
    - echo $IMAGE_TAG
```

Once the application is running, it can be tested with OWASP ZAP (DAST) for vulnerabilities. In the pipeline you must indicate that you want to connect to the previously created and launched application, which will be the system-under-test.

```bash
#### DAST stuff ####
dast:
  variables:
    DAST_FULL_SCAN_ENABLED: "true"
    DAST_BROWSER_SCAN: "true"
    DAST_WEBSITE: "http://calculator-app:5000/"
  services:
    - name: $CI_REGISTRY_IMAGE/calculator/image:$CI_COMMIT_SHORT_SHA
      alias: calculator-app
  needs: ["build_flask_service"]    # build_flask_service is the dind service
```

The connection is done through the `needs` keyword between the running service (calculator) and the DAST test. The running service is described under the `services` section, it will be connected with the aliased name (calculator-app), which is then referenced for the `DAST_WEBSITE` argument.

## Question 3 - Threat model
Describe the sooze infrastructure with the help of a threat model. Follow the STRIDE methodology and find the trust bounderies and some of potential threats.

** → This should be done for the end of your project**

## Question 4 - Commit signing
Turn your commit signing on.

## Question 5 - DAST for Sooze repo
Integrate in your final pipeline a DAST check for the Sooze application.

Provide some specific API routes, that should be tested with the selected DAST solution.
