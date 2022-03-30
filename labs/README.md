This dir contains config files/scripts used to create network architectures which aims to implement certain service mesh concepts on those infrastructures. Utilizes bare linux networking and Kathara framework. All labs are designed to be run on either P4 or Kathara machine included in the repo.

List of labs:
| Lab name | Description | Machine |
|----------| ----------- | --------|
| service-mesh-sd-single-upstream | a subset of a full architecture from HashiCups app that performs service discovery for single case | kathara-machine
| service-mesh-sd-full | the concept from above example extended to the full architecture and all needed rules for app to work correctly | kathara-machine
| manual-two-hosts | #testing, doesn't shows any real concept, was meant to get familiar with container networking but now replaced with Kathara | P4-machine
| manual-signle-switch-two-hosts | #testing, doesn't shows any real concept, was meant to get familiar with container networking but now replaced with Kathara | P4-machine