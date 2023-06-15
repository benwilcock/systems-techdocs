# Getting Started With Tanzu Application Platform

Here are some tips to get you started building and deploying applications on the Tanzu Application Platform.

## Get The Tanzu CLI

To use Tanzu Application Platform it helps to have the Tanzu CLI tool installed. The Tanzu CLI allows you to send your applications (called workloads) to the Tanzu Application Platform so that they can be built and run for you.

See [The Tanzu CLI](tanzu-cli.md)

## Get The Tanzu IDE Plugins

The Tanzu IDE Plugins can assist you from right inside your favorite IDE. These plugins can help you begin new projects, deploy and debug code, and provide a permanent link to the status of your apps running on the platform.

See [Tanzu IDE Plugins](ide-plugins.md).

## Get Context Through The Tanzu Developer Portal

The [Tanzu Developer Portal](tanzu-developer-portal.md) provides all your teams with a rich set of features to create, document, observe, and manage enterprise applications running on Tanzu Application Platform. The Tanzu Developer Portal offers deep contextual awareness of what is running on your platform, the APIs available, and who owns each piece.

## Get Tanzu Smart With The Learning Center

Before deploying your first application, you might like to take a hands on lab called a Leaning Center. These learning centers provide a ready made coding environment where you can safely experiment with the commands and actions required to get the most from the platform.

See [Tanzu Learning Centers](learning-centers.md)

## Start A New Coding Project

Application Accelerators provide ready made coding project templates which you can customize and download. These drastically shorten the time taken to begin new work and encompass best practices fo application design from your organization.

See [Application Accelerators](accelerators.md).

## Run Your Code On The Tanzu Application Platform

Creating or updating a workload is easy. You can use a `workload.yaml` file to simplify the [Tanzu cli](tanzu-cli.md) commands required. Most [application accelerators](accelerators.md) will include this file in the source code they create for you. The [Tanzu IDE plugins](ide-plugins.md) can also send your code to the platform, eliminating cli commands all together. Your source code must also be accessible to the Tanzu Application Platform. Usually this means that the source code is available in a source code repository on a platform like GitHub or GitLab, or sent directly via the IDE plugins.

To run your application on the platform with the [Tanzu CLI](tanzu-cli.md), use the `apply` command:

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