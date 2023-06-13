# Getting Help With Tanzu Application Platform

## Platform Documentation.

The documentation for all versions of Tanzu Application Platform can be found [here](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/index.html).

## Tanzu CLI

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

You can get help with the Tanzu CLI from the tool itself. Most (if not all) of the commands have help available for them. To get help, use the command `help`. Below are some examples.

Get help with the tool itself:

```bash
tanzu help
```

Get help with the **apps** plugin:

```bash
tanzu apps help
```

Get help working with **workloads**:

```bash
tanzu apps workload help
```

## Raising Issues For The Platform

TBC

## Contacting VMware Support

TBC