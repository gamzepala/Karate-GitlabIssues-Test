

Feature: Delete Issue 

Background: Define URL
    * url apiUrl
    * def projectId = 40851737


    Scenario: Delete issue
        Given path 'issues'
        When method Get
        Then status 200
        * def issueId = response[0].iid

        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""

        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404



    
