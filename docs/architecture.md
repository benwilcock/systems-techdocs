# System Architecture

Where for Dinner consists of these core service modules:

* A web UI (`where-for-dinner-ui`)
* A search API for submitting search requests (`where-for-dinner-search`)
* A processor for executing searches against availability sources and managing results (`where-for-dinner-search-proc`)
* An availability API that stores and provides access to the availability results (`where-for-dinner-availability`)

Where for Dinner also has two optional components:

* A web crawler that collects establishment availability and provides a query API (`where-for-dinner-crawler` or `where-for-dinner-crawler-python`)
* A real time notification service that publishes availability to configured destinations (`where-for-dinner-notifiy`)

The high level data flow can be seen in the following diagram:

![High Level Architecture](https://github.com/vmware-tanzu/application-accelerator-samples/blob/9d25e547a7babb67a45cbdc20f9c22b566f17f00/where-for-dinner/doc/images/DinnerHighLevelArch.png?raw=true)

>Note: The event channel protocols are not specified as they can be swapped out with different implementations.  By default, the application uses the RabbitMQ binding for Spring Cloud Streams, but could be swapped for any supported binding.  Because the channel end points are implements as Java `functions`, they are support `CloudEvents` and the event channels can be orchestrated through other mechanisms such as Knative eventing.  As you will see later on, there are provided deployment configurations in this repository for RabbitMQ service binding and Knative eventing.

## Spring Cloud Streams Implementation

The default build and deployment architecture uses Spring Cloud Streams as the asynchronous messaging implementation with RabbitMQ as the default binding.  The messaging topology is depicted in the following simplified architecture diagram: 

![Spring Cloud Streams Messaging](https://github.com/vmware-tanzu/application-accelerator-samples/blob/9d25e547a7babb67a45cbdc20f9c22b566f17f00/where-for-dinner/doc/images/SCSMessaging.png?raw=true)

## Knative Eventing 

The *Cloud Events* option of the Where For Dinner application contains build configuration that removes Spring Cloud Streams dependencies and relies on the Spring Cloud Function webflux library for receiving events over HTTP.  Knative eventing fully embraces this paradigm and integrates seamlessly with functions exposed via the Spring Cloud Functions module.

The architecture still uses Spring Cloud Streams as the messaging implementation for initially emitting searches, and a Knative `source` is inserted to create a bridge between the Spring Cloud Streams binding and the downstream Knative eventing concepts.  For the RabbitMQ implementation, a Knative RabbitMQ Source is declared to read events from a RabbitMQ exchange and propagate them through Knative eventing down to the subscribing services.