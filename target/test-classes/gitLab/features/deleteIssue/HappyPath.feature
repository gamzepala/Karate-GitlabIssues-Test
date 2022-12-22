Feature: Delete Issue 

Background: Define URL
    * url apiUrl

    Scenario: Delete issue
        Given path 'issues'
        When method Get
        Then status 200
        And match response.assignees.username == 'gamze.dedepala'
        * def projectId = response[0].project_id
        * def issueId = response[0].iid

        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""

        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404



    
