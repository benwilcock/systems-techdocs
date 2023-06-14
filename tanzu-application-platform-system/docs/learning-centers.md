# Tanzu Learning Centers

The Learning Center provides a platform for creating and self-hosting hands on labs (known as "workshops"). 

## Taking A Workshop

If the Tanzu Learning Center is installed on your platform, you can take workshops at any time. It's not uncommon for the first workshop that you take to be "Getting Started With Tanzu Application Platform" where you'll learn all about the tanzu-cli, the application accelerators, and more.

![Learning Center In Action](./images/learning-center-anim.gif)

The Learning Center training portal is not integrated into the Tanzu Application Platform Developer Portal, but it is often deployed alongside it. Ask your platform operator for details. In the author's platform, the learning center URL can be found using the following `kubectl` command:

```bash
kubectl get trainingportals
```

The output:

| NAME                   | URL                                                      | STATUS  |
|------------------------|----------------------------------------------------------|---------|
| learning-center-guided | http://learning-center-guided.learningcenter.example.com | Running |


## Creating Your Own Workshops

The Tanzu Learning Center allows you to create workshops using markdown files. These instructions create an environment that is displayed to the learner in the Learning Center UI. The Learning Canter UI can embed slide content, an integrated development environment (IDE), a web console for accessing the Kubernetes cluster, and other custom web applications.

Although Learning Center requires Kubernetes to run (and is sometimes used to teach users about Kubernetes) you can use it to host training on a multitude of topics. For example, you can use it to help train users in web-based applications, use of databases, or programming languages, and more.

For more details on how to create workshops, refer to the [Tanzu Application Platform Documentation](https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/index.html).

