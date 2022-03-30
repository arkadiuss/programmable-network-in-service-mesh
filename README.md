# Applicability of programmable network devices in service mesh architectures

This repository contains work used in my master thesis: "Applicability of programmable network devices in service mesh architectures". It is made of a bunch of labs/architectures on which I present and test implementations of service mesh concepts. 

## Structure
At this points the work is structured in the following directories: 
- `labs` - main directory that contains scripts/config files to run virtual network architecture on which some service mesh concepts are presented and tested. Each lab contains a separate description what is presented in it.
- `hasicups-docker-images` - the goal was to present concepts on a real architecture so this directory contains docker files to build hosts that runs a reference app ([HashiCups](https://github.com/hashicorp-demoapp)). Services of this app are put randomly on a different hosts to simulate app deployed using container orchestrator.
- `*-machine` - contains Vagrantfiles for machines that contains a required software to run the app.
