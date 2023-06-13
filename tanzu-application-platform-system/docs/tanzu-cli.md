# The Tanzu CLI

The tanzu command line interface (CLI) is your local tool for interacting with the suite of VMware Tanzu products. This tool allows you to deploy and manage the life cycles of not only Kubernetes clusters, but also application workloads, continuous integration and continuous deployment (CI/CD) pipelines, various packages, as well as other development workflows that leverage Tanzu technologies running on those Kubernetes clusters.

[Tanzu CLI Command Reference](https://docs.vmware.com/en/VMware-Tanzu/services/vmware-tanzu-cli-ref/GUID-index.html)

### Basic CLI Commands

Here are some basic commands you may find useful when working with workloads that are running on the platform.

Listing your workloads (and their status):

```bash
tanzu apps workload list
```

Getting the details of a workload (including its URL if that is available):

```bash
tanzu apps workload get <workload-name>
```

Creating or updating a workload (requires `workload.yaml` file):

```bash
tanzu apps workload apply -f path/to/workload.yaml
```

Deleting a workload (removes it from the system):

```bash
tanzu apps workload delete <workload-name>
```

