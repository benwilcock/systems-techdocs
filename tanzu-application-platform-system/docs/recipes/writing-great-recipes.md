## Problem

You would like to write a recipe to share knowledge with others. The recipe should be written in such a way as to support readers, by making it easy to grasp the essence of the content and decide whether it is applicable in their context.

## Solution

We provide guidelines, backed by user research, for the title and content of recipes. We also provide a recipe template with our recommended structure.

### Title

The title of a recipe is often the first aspect that a reader sees, whether it is in the list of recipes for a category or in a user's search results. The title helps the user decide whether a recipe is relevant to them, which is why it is very important for the recipe's title to match the content. Please make sure that the title says exactly what the recipe is about and what distinguishes this recipe from similar ones (e.g. the tech stack or environment).

We recommend starting titles with a gerund. For example: "*Implementing* Authentication with Spring Security Through a Custom HTTP Header".

### Content

A recipe should include the following content:

* **PROBLEM: A description of the problem to solve.** Explain the context of the recipe: when does the problem occur? How can the reader tell if they have the same problem?
* **SOLUTION: A description of the provided solution.** Briefly explain how and why your solution works.
* **STEPS: The steps to be taken in order to solve the problem.** Explain, step by step, how you solved the problem. Go into detail when necessary. Make the explanation accessible for readers with less knowledge about the topic than you have. Include code snippets where helpful and comment/explain them. As we practice Test-Driven Development (TDD), we would be very appreciative if you would test your recipe instructions.
* **REFERENCES: References and further reading.** Include links to references and further reading material. For each link, explain briefly in which situations you would consult the link.

The purpose of the problem and solution descriptions is to help the reader assess the relevance of a recipe: "Does the problem match the issue I am currently facing?", "Can I reuse this solution given the constraints of my project?"

In customer engagement situations, we often need to figure this out in a short amount of time. That's why the problem and solution descriptions should be as succinct as possible, but as detailed as necessary.

Some additional guidelines while adding or changing a recipe:

* **Use the same directory structure for your images.**
    If you want to add an image named `overview.jpg` to your recipe `my-recipe.md` which is located in the `recipes` directory, the image should be saved in `/images/recipes/my-recipe/overview.jpg`. This way it is easier to maintain the growing number of recipes and easier to remove obsolete recipes and their images.

* **Keep your recipe as abstract as possible.**
    Try to leave customer- and environment-specific information, like network names, out of the recipe.
    It might be that someone reads the problem and solution statement and is facing the same problem as you had.
    If that person then continues reading the steps you wrote down and is not familiar with eg. the network segment you are operating in, then the reader can not use this recipe.

### Template and recipe structure

Please use the template provided below for your next recipe. 

--------------------------------------------------------------

## Problem

Explain the context of the recipe. When does the problem occur? How can the reader identify whether they have the same problem?

For example: "The application needs to authenticate and authorize a request using a custom HTTP header containing authentication information that is passed by load balancers."

## Solution

Briefly summarize your solution.

For example: "Add a servlet filter that checks whether the header exists, and if so, stores the header's content in a request object property."

### How does it work?

Tell the reader how and why your solution works.

For example: "Every incoming request will pass through the Servlet filter, which places authentication data in a request property. This property is then available to the rest of the application, where it can be used to identify users and authorize requests." 

### How do I do it?

Explain, step by step, how you solved the problem yourself. Go into detail when necessary. Make the explanation accessible for readers with less knowledge about the topic than you have. Include code snippets where helpful, and comment/explain them. As we practice Test-Driven Development (TDD), we would be very appreciative if you would test your recipe instructions.

For instance:

1. Create a servlet filter class.
    ```
    (code example here)
    ```
1. Add a test for the filter.
    ```
    (another code example here)
    ```
1. Register your filter.

and so on.

## References

Include links to references and further reading material. For each link, explain briefly in which situations you would consult the link.

For example:

* [Spring Security Reference: Servlet Security](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#servlet-architecture) --- explains the Servlet filter concept and the Spring Security architecture

----------------------------------------------------------------------------

## Markdown Syntax Cheat Sheet

This is how... 

* to link to an **external** page:
    ```markdown
    [Link title](https://example.com)
    ```

* to link to an **internal** page:
    ```markdown
    [Link title](./relative-path-to/some-other-recipe.md)
    ```

* to embed an **image**:
    ```markdown
    ![Alt text](images/recipes/my-recipe/my-image.png)
    ```

## References

* **Technical writing**
    * [SpringOne 2020: If Hemingway Wrote JavaDocs](https://springone.io/post-event/sessions/if-hemingway-wrote-javadocs) --- for best practices on writing helpful technical documentation
    * ["5 Tips For Writing Interesting Technical Articles"](https://dzone.com/articles/5-tips-for-writing-interesting)
    * [Wikiversity page with style recommendations for technical writing](https://en.wikiversity.org/wiki/Technical_writing/Style) --- if you would like to learn more about writing as clearly as possible
    * [Mailchimp Content Style Guide: Writing Technical Content](https://styleguide.mailchimp.com/writing-technical-content/) --- some more tips on technical writing (other sections of the Mailchimp Content Style Guide include tips on writing in general)

* **Grammar**
    * [Grammarly writing assistant](https://www.grammarly.com/) --- to check your grammar
    * [An interactive guide to ambiguous grammar](https://www.mcsweeneys.net/articles/an-interactive-guide-to-ambiguous-grammar)

* **Markdown**
    * [Mastering Markdown: GitHub Guides](https://guides.github.com/features/mastering-markdown/) --- for basic Markdown syntax
    * [CommonMark Markdown cheat sheet](https://commonmark.org/help/) --- for a quick overview of the CommonMark Markdown syntax that Hugo's Markdown renderer is compliant with
    * [CommonMark Markdown specification](https://spec.commonmark.org/) --- for all of the details about CommonMark