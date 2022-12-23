Feature: Negative Tests

    Background: Define URL
        * url apiUrl

        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id
        * def issueId = response[0].iid 

    Scenario: Attempting to delete a resource that does not exist 
    
        
     
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


    Scenario: Attempting to delete a non-existent issueId
        

        * def currentIssueId = issueId + 2

        
        Given path "projects",projectId,"issues", currentIssueId
        When method Get
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Not found"}

        Given path  "projects", projectId,"issues", currentIssueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Issue Not Found"}

    Scenario: Attempting to delete a non-existent projectId
        
     
        * def currentProjectId = issueId + 2
        
        Given path "projects",currentProjectId ,"issues", issueId
        When method Get
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Project Not Found"}
    
        Given path  "projects", currentProjectId ,"issues", issueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Project Not Found"}


    
