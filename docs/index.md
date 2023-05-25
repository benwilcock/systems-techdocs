# Where For Dinner?

The Where for Dinner dining search solution is a microservice application that implements a relatively contemporary architecture comprised of the following technologies:

* ReactJS Web Front End
* Reactive REST Web Services (WebFlux)
* Reactive Database Access (R2DBC)
* Asynchronous Eventing (Spring Cloud Streams and Functions)
* State (Redis)
* Security (oAuth and Tanzu AppSSO)

Along with Spring Cloud Stream, CloudEvents and Knative eventing are supported as an alternative deployment option with a small change in application dependencies (but no source code changes).  This alternative deployment method also supports Knative scale to zero as well as auto scaling. 

The default application configuration supports static out of the box data sets; however, is also contains options to configure alternative data sources.  Lastly, the asynchronous messaging model supports the ability to add applications to the extend functionality.

