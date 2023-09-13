# Applicability of programmable network devices in service mesh architectures

This repository contains work used in my master thesis: "Applicability of programmable network devices in service mesh architectures". It is made of a bunch of labs/architectures on which I present and test implementations of service mesh concepts. 

## Abstract (from thesis)
Service mesh is an emerging trend because of a plethora of possibilities it offers. It is based on some concepts, like control and data plane separation, that are in the core of mature technology - Software Defined Networks (SDN). The similarity between those two concepts has already been noticed and L2-L7 SDN has been proposed. This thesis attempts to take advantage of programmable network switches in order to achieve service mesh functions in new or existing systems. The objective is to review existing features of programmable devices and their applicability in service meshes, as well as to implement and evaluate some concepts using them. The work includes: implementation of service mesh functions using OpenVSwitch, integration of proposed solution with Kubernetes, and investigation of other tools and solutions like data plane programmability to extend the proposed base. The results show that a service mesh with limited functions is possible to achieve and that its performance is around two times better than the existing service mesh.

## Structure
The work is structured in the following directories: 
- `ovs-service-mesh-cni-k8s-consul-deployment` - contains k8s resource files to present thesis' concepts integrated with Kubernetes 
- `labs` - main directory that contains scripts/config files to run virtual network architecture on which some service mesh concepts are presented and tested. Each lab contains a separate description what is presented in it.
- `hasicups-docker-images` - the goal was to present concepts on a real architecture so this directory contains docker files to build hosts that runs a reference app ([HashiCups](https://github.com/hashicorp-demoapp)). Services of this app are put randomly on a different hosts to simulate app deployed using container orchestrator.
- `*-machine` - contains Vagrantfiles for machines that contains a required software to run the app.
