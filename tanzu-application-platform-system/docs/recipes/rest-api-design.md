This is a recipe that describes the strategy used to design a RESTful API.  The goal of this strategy is to enable the implementation of at least a level 2 API as defined by the [Richardson Maturity Model](https://martinfowler.com/articles/richardsonMaturityModel.html).  This strategy defines the characteristics of the following aspects of the API.

1. Media Types
1. URI Design
1. HTTP Methods
1. Resource Design
1. Select Response Status Codes
1. Define Headers
1. Query Parameter Design
1. Define API Evolution strategy

## Media Types

In the majority of the cases, this would simply be `application/json`, but occasionally other media types can be useful such as:

- `application/x-www-form-urlencoded`
- `multipart/form-data`


## URI Design

URIs should be described using nouns.  Plural nouns to describe collection resources.  Singular resources most often will be referenced via an identifier.  However, in the case where only one resource can exist, then use a singular noun.

In general it is best to avoid using camel case when defining URIs.  Instead, if the resource name contains multiple words, then a '-' would typically be used.  However, if the format of the resource is snake case, then '\_' tends to be more common.

URI collisions should attempt to be avoided if possible.  For example, defining two URIs such as /orders/{id} and /orders/count.

## HTTP Method Strategy

**GET**

Used to retrieve a resource.  A `GET` request should never alter the state of of the resource and should be idempotent.

**POST**

As per the HTTP spec, the POST method should be used to create a resource.  It is not http spec compliant, but it is common for a POST to be used to perform a merge update in lieu of `PATCH`.  `POST`, more often than not, will not be idempotent.  The first `POST` request may create a resource while subsequent requests would result in a 4XX error due to the resource already existing.  `POST` to perform merge updates however, would be idempotent.

**PUT**

Used to replace an existing resource.  If a resource needs to support nulling out optional attributes, then `PUT` could be used.

**DELETE**

Used to remove a resource.  Normally `DELETE` would not be idempotent since the first request would be successful while subsequent requests would return a 404 error.

**PATCH**

Is intended to be used to perform a merge update on a resource.  `PATCH` can also be used to assign null to optional attributes.  However, it is considered a best practice to follow the [patch spec](https://tools.ietf.org/html/rfc5789#section-2.1) and not to [Patch Like an Idiot](http://williamdurand.fr/2014/02/14/please-do-not-patch-like-an-idiot/).

**OPTIONS**

Spring boot provides support for OPTIONS so no additional coding is needed unless the API needs support for [CORS](https://spring.io/guides/gs/rest-service-cors/ "Spring CORS Tutorial").

### Summary

Using `GET` to retrieve, `POST` to create, `PUT` to update, and `DELETE` to remove is commonly agreed upon.  How to perform partial updates  is where there tends to be some contention.  However, there are two general strategies that are most commonly used. <br>
1) Use `POST` to collection resource to create, `POST` to a singular resource for partial updates, and `PUT` to singular resources for complete replace. <br>
2) Only use `POST` to create and `PATCH` for updates.  While this strategy is more compliant with the HTTP spec, the former strategy tends to be more popular due to the complexity around using `PATCH`.

## Resource Design Concepts

Resource content generally is provided only for `POST`, `PUT`, and `PATCH` requests.  The HTTP spec supports content to be provided for `DELETE` requests, but this practice is generally discouraged.  `GET` requests can at times be a point of contention since it is somewhat unclear in the HTTP spec if `GET`s are allowed to have request content, but this would be discouraged as well.  This issue tends to arise for APIs that provide complex searching functionality.

Resource content provided in the request generally should match what is returned in the response.  The only exception is for attributes that are defined in the schema as read only.  It is discouraged to define attributes for the request that would never be returned in the response. In addition, the type of resource returned should be the same type as what was provided.  For example, a `POST /customers/{id}` would be provide a customer resulting in a customer to be returned instead of a collection of customers.

The general rule to use to determine when to return response content is that if the response content would match the request content, then no  content would need to be returned.  In this situation, a `204` status should be returned.  However, a single URI returning multiple successful response status should be avoided.

It is strongly discouraged to provide a `links` attribute as part of resource response content for `application/json` media types.

**Singular Resources** <br>
Short and concise naming of attributes resource.

``` json
{
  "id": "7877a21a721f0fe399dc6f1086a45892",
  "firstName": "Sam",
  "lastName": "Spurlock",
  "username": "sspurlock",
  "email": "sspurlock@exampleorg.com",
  "locale": "en",
  "created": "2009-04-15T00:50:04Z"
}
```

**Collection Resources** <br>
Consideration should be given to the potential size of a collection resource.  For large collections, a pagination solution may be needed.  The following example shows the basic structure for a collection resource without pagination.
``` json
[
	{ ... },
	{ ... }
]
```

The following example shows the basic structure for a collection resource with pagination.  It is considered good practice to include `limit`, `offset`, and `count` as part of the response for a collection resource where `offset` and `limit` would have corresponding query parameters.
``` json
{
  "customers": [
    { ... },
    { ... }
  ],
  "offset": 0,
  "limit": 10,
  "count": 20
}
```

**Error Responses** <br>

There are certainly a number of valid ways to design error response content.  General recommendations would be to ensure that all errors have a unified format and provide errors in a way that would accommodate multiple errors to be returned in case multiple aspects of the request failed validation.

It can be beneficial for each error to have a `code` and `subcode` attribute. Having a `subcode` attribute can help mitigate the creation of a new version of the API since the creation of a new code value could be considered a non-backward compatible change.  A `localizedMessage` may also be needed if a localized (based on the `accept-language` header) needs to be provided.

**Example**
``` json
[
  {
    "code": "error-code-1",
    "subcode": "sub-error-code-1",
    "description": "short reason for the cause of error code 1",
    "localizedMessage": "Première erreur d'exemple"
  },
  {
    "code": "error-code-2",
    "subcode": "sub-error-code-2",
    "description": "short reason for the cause of error code 2",
    "localizedMessage": "Deuxième exemple d'erreur"
  }
]
```

## HTTP Status Code Selection

Code | Description
--- | ---
200 | Resource updated
201 | Resource created and a Location header provided that can be used to retrieve the resource.  Response content optional.
202 | Resource accepted and `Retry-After` and `Location` headers provided that can be usewd to retrieve the resource. Response content optional.
304 | Successful response for a GET request indicating resource has not been modified since previous GET. <br>  Would be supported as part of a conditional GET mechanism.
400 | Malformed Request
403 & 401 | Authentication and Authorization failures
404 | Invalid URI or Singular resource not found
405, 406, & 415 | Invalid Method, Accept, or Content Header all of which are handled by spring
422 | Request violates business validation rules
500 | Internal error occurred

## Define Headers

Common convention dictates that Cookies should not be leveraged by RESTful APIs.

**Request Headers**

In general, the implementation of custom request headers should be rare with the exception of things such as versioning or client application identification(ie client/secret keys).

**Response Headers**

The implementation of custom response headers should be fairly common. Some common examples of custom response headers would be for things such as a *request UUID* and *resource type*.

If hypermedia links would be needed provided by responses, the [link header](https://www.w3.org/wiki/LinkHeader) is an option worth consideration.

## Query Parameter Design

Query parameters are generally defined only for `GET` requests and tend to be used more predominately with collection resources. Defining query parameters for other methods is generally considered bad practice. However, `POST`s that support query parameters so that request content need not be provided can help simplify web applications that consume API responses.

In order for an API to remain intuitive and easy to learn, it is advantageous to refrain from implementing action query parameters.

A common approach is to have query parameters where the name matches one of the attributes in the resource in order to provide collection resource filtering.

When pagination is needed for a collection resources, generally recommended to use `limit` and `offset` query parameters.

Query parameters are typically optional.  Defining query parameters that are required for a request is generally considered bad practice.

### Examples

Example request to check if a customer exists for a given `username`.  The response would always be a collection resource.  An empty collection would be returned if no customers were found.  A `404` error should not occur in that case.
``` text
GET /customers?username={name}
```

Example request to pull a given number of orders over a specified amount
``` text
GET /orders?amount>{amount}&limit={limit}
```

## Evolution Strategy

First step in determining a version strategy is to come to agreement on the definition of a non-backward compatible change.
A common approach is to adopt the [tolerant reader](https://martinfowler.com/bliki/TolerantReader.html) principle.  This can help mitigate the creation of new versions.

### Non-versioning strategy

The non-versioning strategy entails always making enhancements to an API in a backwards compatible fashion.  In the event that this cannot be done, then a temporary version of the API is created and a process is initiated that would upgrade all consuming application to the latest version.  Once the process is completed, the legacy version is then removed.

Ideally an API could start without a versioning mechanism in place and one would not be implemented until the time one is actually needed.

### Versioning strategy

There are number of common API versioning strategies that can found.  One of these is a strategy based on a custom header approach where the value is a date.  How the date is determined can be done a few ways.  

One approach is to have the consuming application always provide it as part of every request.  Another approach is to have a gateway application (such as Spring Cloud Gateway) that captures the event of the first request and store the date with the associated principal.

Regardless of how the header is determined, the version header approach works nicely since it allows for specific aspects of the API to be versioned rather than having to version the entire API.  It also plays well with gateway applications that perform orchestration since the gateway would not need to know anything about what versions exists for each origin service.  Lastly, this versioning strategy would need to be implemented until the time a versioning mechanism is needed.

Using a URL based versioning strategy is losing popularity and should be avoided. The following is a comment from Fielding reflects his view on this approach.

> **Roy T. Fielding** <br>
_@fielding_ <br>
The reason to make a real REST API is to get evolvability … a "v1" in the URL indicates the API is RPC/HTTP (not REST)

