## Context

Define API Versioning options and a go-forward approach for new services. 

- Objectives:
    - Embrace change but aim to provide forward compatibility
    - Evolve API's without unnecessarily breaking clients
    - Surface breaking changes as early as possible
    - Leverage continuous integration to shorten feedback loops and prevent accidental breaking of API's
    - "Service implementations should be conservative in what they produce, but liberal in what they accept from others" -Postel's Law
    - Prefer additive changes vs breaking changes
    - Allow service to evolve independently
    - When a service is used by multiple clients ideally ALL changes to the service need to be backwards compatible. If this is not possible then implement [parallel change](https://martinfowler.com/bliki/ParallelChange.html).

## Options

- URL Path Variable

    - Add the version to the base of the URL
        - `https://localhost:8080/api/v2/version-hello-world`

    - Pros
        - Easy to implement
        - Convenience to use URL's without headers
    - Cons
        - Limited flexibility
        - Can be a burden to maintain over time
        - The resource changes on version changes
    - Examples:
        - Twitter, Google Search, Facebook, Pivotal Tracker

- URL Query Parameters

    - Include the version number as a query parameter
        - `https://localhost:8080/api/version-hello-world?version=1`

    - Pros
        - Easy to implement
        - Convenience to use URL's without headers
    - Cons
        - Limited flexibility
        - Parameters are for service functions not attributes of the implementation
        - The resource changes on version changes
        - Need to parse the entire string before routing
    - Examples:
        - Netflix, Microsoft

- Request Header

    - Include the version number as a query parameter
        - `curl -H "X-API-Version:V1" https://localhost:8080/api/version-hello-world`

    - Pros
        - Version a single resource representation instead of the entire API
        - Convenience to use URL's without headers
    - Cons
        - More difficult to test
        - Less accessibility 
    - Examples:
        - Facebook, Twitter
        
- Content Negotiation

    - Include the version number as a query parameter
        - `curl -H "Accept: application/vnd.bootiful.demo-v1+json" https://localhost:8080/api/version-hello-world`

    - Pros
        - Version a single resource representation instead of the entire API
        - Easier to maintain
    - Cons
        - More difficult to test
        - Less accessibility
    - Examples:
        - [GitHub](https://developer.github.com/v3/media/)
        
        

## Backwards Compatibility 

>Backwards-compatible (non-breaking) changes
>- Adding an API interface to an API service
>- Adding a method to an API interface
>- Adding an HTTP binding to a method
>- Adding a field to a request message
>- Adding a field to a response message
>- Adding a value to an enum
>- Adding an output-only resource field


>Backwards-incompatible (breaking) changes
>- Removing or renaming a service, interface, field, method or enum value
>- Changing an HTTP binding
>- Changing the type of a field
>- Changing a resource name format
>- Changing visible behavior of existing requests
>- Changing the URL format in the HTTP definition
>- Adding a read/write field to a resource message

## API Maturity Model

>Level 0: The swamp of POX
(Naturally, it would be zero-indexed!) Describes APIs that use HTTP as a transport and nothing more. SOAP-based web services, for example, use HTTP, but they could as easily use JMS. They are, incidentally, HTTP-based. Such a service uses HTTP mainly as a tunnel through one URI. SOAP and XML-RPC are examples. They usually use only one HTTP verb (POST).

>Level 1: Resources
Describes APIs that use multiple URIs to distinguish related nouns, but otherwise avoid the full features of HTTP.

>Level 2: HTTP verbs
Describes APIs that leverage transport-native properties (like HTTP verbs and status codes) to enhance the service. If you do everything incorrectly with Spring MVC or JAX-RS or any other modern-day REST framework, you’ll still probably end up with an API that’s level 2 compliant! This is a great starting point.

>Level 3: Hypermedia controls (HATEOAS, for Hypermedia as the Engine of Application State)
Describes APIs that require no a priori knowledge of a service in order to navigate it. Such a service promotes longevity through a uniform interface for interrogating a service’s structure.

Resources:
- [Google API Versioning](https://cloud.google.com/apis/design/versioning)
- [Cloud Native Java](https://www.safaribooksonline.com/library/view/cloud-native-java/9781449374631/)
- [Microsoft API Guidelines](https://github.com/Microsoft/api-guidelines/blob/master/Guidelines.md#12-versioning)
