# Getting Started (Application Developers)

To use Tanzu Application Platform it helps to have the Tanzu CLI tool installed. The Tanzu CLI allows you to send your applications (called workloads) to the Tanzu Application Platform so that they can be built and run for you.

You can download the Tanzu CLI binary from [TanzuNet](https://network.tanzu.vmware.com/products/tanzu-application-platform/).

## Starting A New Coding Project

See [Application Accelerators](accelerators.md).

## Running Your Code On The Tanzu Application Platform

Creating or updating a workload requires `workload.yaml` file. Most accelerators will include this file in the source code they create for you. Your source code must also be accessible to the Tanzu Application Platform. Usually this means that the source code is available in a source code repository on a platform like GitHub or GitLab.

To run your application on the platform, use the Tanzu CLI `apply` command:

```bash
tanzu apps workload apply -f path/to/workload.yaml
```

To get the URL for your application, use the Tanzu CLI `get` command:

```bash
tanzu apps workload get <workload-name>
```

## Other Common Tanzu CLI Commands

Here are some basic commands you may find useful when working with workloads that are running on the platform.

Listing your workloads (and their status):

```bash
tanzu apps workload list
```

Getting the details of a workload (including its URL if that is available):

```bash
tanzu apps workload get <workload-name>
```

Deleting a workload (removes it from the system):

```bash
tanzu apps workload delete <workload-name>
```

There's more information about the Tanzu CLI on the [tanzu cli page](tanzu-cli.md).

## Getting Help

See [help](help.md) for useful places to start if you need assistance with Tanzu Application Platform.

## Tanzu Application Platform Documentation.

The documentation for all versions of Tanzu Application Platform can be found [here](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/index.html).