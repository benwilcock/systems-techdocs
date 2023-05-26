# Introducing: Where For Dinner!?

![Diner](images/icon.png)

The Where for Dinner dining search is a microservice application that implements a relatively contemporary architecture comprised of the following technologies:

* [ReactJS](https://react.dev/) Web Front End
* [Spring Reactive REST](https://spring.io/guides/gs/reactive-rest-service/) Web Services (WebFlux)
* [Spring Reactive Database](https://spring.io/projects/spring-data-r2dbc) Access (R2DBC)
* Asynchronous Eventing ([Spring Cloud Streams](https://spring.io/projects/spring-cloud-stream) and Functions)
* State ([Spring Data Redis](https://spring.io/projects/spring-data-redis))
* Security (oAuth and [Tanzu AppSSO](https://docs.vmware.com/en/Application-Single-Sign-On-for-VMware-Tanzu/1.0/appsso/GUID-getting-started-appsso-overview.html))

Along with Spring Cloud Stream, CloudEvents and Knative eventing are supported as an alternative deployment option with a small change in application dependencies (but no source code changes).  This alternative deployment method also supports Knative scale-to-zero as well as auto-scaling. 

The default application configuration supports static out of the box data sets; however, is also contains options to configure alternative data sources.  Lastly, the asynchronous messaging model supports the ability to add applications to the extend functionality.

Read on to find out:

* [How Where For Dinner works behind the scenes](how-it-works.md)
* [How the application was constructed (its architecture)](architecture.md)
* [How it started life as an Application Accelerator and how to build it yourself](create-your-own.md)

[Try Where For Dinner](http://where-for-dinner.tap-next.blah.cloud/)


## Want To Build These TechDocs?

You can find the code and process used to build these TechDocs in the [source code repo on GitHub](https://github.com/benwilcock/where-for-dinner-techdocs). The solution consists of a Docker image that you build and run locally and a script that utilizes the [TechDocs CLI](https://backstage.io/docs/features/techdocs/cli/). The resulting site is hosted on an Amazon S3 compatible bucket that has been made available to Backstage.

The resulting TechDocs are referenced by the Where For Dinner catalog entry (Where For Dinner is of kind `System`). The entity looks something like this. 

```yaml
apiVersion: backstage.io/v1alpha1
kind: System
metadata:
  name: where-for-dinner
  description: A fully functional microservices reference application
  annotations:
    backstage.io/techdocs-ref: url:https://github.com/benwilcock/where-for-dinner-techdocs
```

> In the near future we hope to incorporate this TechDocs builder task into our regular secure software supply chains, or to have a standalone supply chain dedicated to this task.
