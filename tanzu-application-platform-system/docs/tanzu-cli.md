The `tanzu` command line interface (CLI) is your local tool for interacting with the suite of VMware Tanzu products including Tanzu Application Platform. This tool allows you to deploy and manage the life cycles of not only Kubernetes clusters, but also application workloads, continuous integration and continuous deployment (CI/CD) pipelines, various packages, as well as other development workflows that leverage Tanzu technologies running on Kubernetes clusters.

## Download the Tanzu CLI

You can download the Tanzu CLI binary for your operating system from [TanzuNet](https://network.tanzu.vmware.com/products/tanzu-application-platform/).

## Getting Started With The Tanzu CLI

Here are some basic commands you may find useful when working with the Tanzu Application Platform.

Listing your workloads (and their status):

```bash
tanzu apps workload list
```

Getting the details of a workload (including its URL if that is available):

```bash
tanzu apps workload get <workload-name>
```

Creating or updating a workload (the `-f` switch simplifies this command by using a `workload.yaml` file to store some finer details. Other options are available.):

```bash
tanzu apps workload apply -f path/to/workload.yaml
```

Deleting a workload (removes the workload you'd previously registered from the platform but does not touch your local source code):

```bash
tanzu apps workload delete <workload-name>
```

## Getting Help

The Tanzu CLI includes built in help. To get help with a command, add the word `help` before any options. For example:

```bash
tanzu help # To get help wth the tool itself
tanzu apps help # To get help with the `apps` plugin
tanzu apps workload help # To get help with workload tasks
```

## Gain Superior Knowledge From the Documentation 

The [Tanzu CLI Command Reference](https://docs.vmware.com/en/VMware-Tanzu/services/vmware-tanzu-cli-ref/GUID-index.html) contains more information about the command line, its features and its use.




