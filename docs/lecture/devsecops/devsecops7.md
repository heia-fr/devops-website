---
title: Productive operations and attack response
---

# {{ title }} (Maintenance & Operation)

The word DevSecOps contains the part Ops, i.e. the operation of the system. In this phase, too, security is a non-negligible part of the whole. It must be constantly monitored to ensure that no vulnerabilities emerge, that no vulnerable software/libraries are in use, and that no attacks are launched against the system.

For this reason, the following tasks and maintanance jobs must be done during the operations phase:

- Monitoring
- Vulnerability management
- Secure Disposal

!!! information "Monitoring"
    Intelligent monitoring of the system. What kind of data should be logged, what amount of data must be kept, how long is this information necessary, where are these logs stored, ... ?

    How to react in the case of an emergency? Be prepared, have a plan, where are the stakeholder, allow fast reaction.

    Tools and services to provide a good overview (IDS, LoadBalancer, ReverseProxy, WAF, etc.). These helping blocks should log just a little more data than you would need in an emergency (think also for a possible forensic research).

!!! information "Vulnerability management"
    Use official sources of vulnerabilites like [CWE](https://cwe.mitre.org/).

    You must know your inventory (software bill of material - SBOM). Often also called **[software supply chain](https://en.wikipedia.org/wiki/Software_supply_chain)**, which contains the information about:

    - components
    - libraries
    - tools
    - process to develop, build and publish

