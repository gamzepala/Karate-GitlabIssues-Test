

Feature: Destructive test

Background: Define URL
    * url apiUrl
    * def projectId = 40851737
    * def issueRequestBody = read("classpath:gitLab/json/requestJson/emptyNewIssueRequest.json")

    Scenario: Empty payload request
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 400
        Then match response == {"error": "issue_type does not have a valid value"}
        

 




    
