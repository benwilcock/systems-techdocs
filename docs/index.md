# Where For Dinner?

The Where for Dinner dining search solution is a multi micro-service application that implements a relatively contemporary architecture comprised of the following technologies:

* ReactJS Web Front End
* Reactive REST Web Services (WebFlux)
* Reactive Database Access (R2DBC)
* Asynchronous Eventing (Spring Cloud Streams and Functions)
* State (Redis)
* Security (oAuth and Tanzu AppSSO)

Along with Spring Cloud Stream, CloudEvents and Knative eventing are supported as an alternative deployment option with a small change in application dependencies (but no source code changes).  This alternative deployment method also supports Knatvie scale to zero as well as auto scaling. 

The default application configuration supports static out of the box data sets; however, is also contains options to configure alternative data sources.  Lastly, the asynchronous messaging model supports the ability to add applications to the extend functionality.

## Create & Customize Your Own Version

This entire Where For Dinner application and all its microservices can be creating using an "Accelerator." You can use this accelerator from inside your IDE using the [Tanzu Application Platform Application Accelerator Extension](https://network.tanzu.vmware.com/products/tanzu-application-platform/), or from the [Tanzu Application Platform Developer Portal](#) by cliclikg the "Create (+)" option in the left hand navigation menu. Look for the "Where For Dinner" accelerator and fill in the various form fields to customize your initial project. Once you have your accelerator project, you can customise further it as you wish.

## Application Architecture

Where for Dinner consists of five main service modules:

* A web UI service (`where-for-dinner-ui`)
* An API service for submitting search requests (`where-for-dinner-search`)
* A processor service for executing searches against availability sources and managing results (`where-for-dinner-search-proc`)
* An API service that stores and provides access to availability results (`where-for-dinner-availability`)

Where for Dinner also has two optional components:

* A crawler service that collects establishment availability and provides a query API (`where-for-dinner-crawler` or `where-for-dinner-crawler-python`)
* A real time notification service that publishes availability to configured destinations (`where-for-dinner-notifiy`)

The high level data flow looks like the following:

![High Level Architecture](https://github.com/vmware-tanzu/application-accelerator-samples/blob/9d25e547a7babb67a45cbdc20f9c22b566f17f00/where-for-dinner/doc/images/DinnerHighLevelArch.png)

Note that the event channel protocols are not specified as they can be swapped out with different implementations.  By default, the application uses the RabbitMQ binding for Spring Cloud Streams, but could be swapped for any supported binding.  Because the channel end points are implements as Java `functions`, they are support `CloudEvents` and the event channels can be orchestrated through other mechanisms such as Knative eventing.  As you will see later on, there are provided deployment configurations in this repository for RabbitMQ service binding and Knative eventing.

### Spring Cloud Streams Implementation

The default build and deployment architecture uses Spring Cloud Streams as the asynchronous messaging implementation with RabbitMQ as the default binding.  The messaging topology is depicted in the following abridged architecture diagram: 

![Spring Cloud Streams Messaging](https://github.com/vmware-tanzu/application-accelerator-samples/blob/9d25e547a7babb67a45cbdc20f9c22b566f17f00/where-for-dinner/doc/images/SCSMessaging.png)

### Knative Eventing 

The *Cloud Events* option of the Where For Dinner application contains build configuration that removes Spring Cloud Streams dependencies and relies on the Spring Cloud Function webflux library for receiving events over HTTP.  Knative eventing fully embraces this paradigm and integrates seamlessly with functions exposed via the Spring Cloud Functions module.

The architecture still uses Spring Cloud Streams as the messaging implementation for initially emitting searches, and a Knative `source` is inserted to create a bridge between the Spring Cloud Streams binding and the downstream Knative eventing concepts.  For the RabbitMQ implementation, a Knative RabbitMQ Source is declared to read events from a RabbitMQ exchange and propagate them through Knative eventing down to the subscribing services.  The following is a diagram of the Knative event concepts used for Where For Dinner:

![](doc/images/KnativeEventing.png) 