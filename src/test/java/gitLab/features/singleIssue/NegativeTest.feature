
Feature: Negative Tests

    Background:
        * url apiUrl
        * def projectId = 40851737
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")

    Scenario: Attempting to create a new issue that  a title is empty
       
        # Create new issue empty title
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        * set issueRequestBody.title = ''
        When method Post
        Then status 400
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message":{"title":["can't be blank"]}}

       
      


