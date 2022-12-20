
Feature: Negative Tests

    Background: Define URL
    * url apiUrl
    * def projectId = 40851737
    * def deleteIssueId = 180
    

    Scenario: Attempting to delete a resource that does not exist 
        Given path 'issues'
        When method Get
        Then status 200
        * def issueId = response[0].iid

        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""

        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response ==  {"message":"404 Issue Not Found"}


    Scenario: Attempting to delete a resource without 
        Given path "projects",projectId,"issues", deleteIssueId
        When method Get
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Not found"}

        Given path  "projects", projectId,"issues", deleteIssueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Issue Not Found"}


    
