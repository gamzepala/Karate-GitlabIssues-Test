# Delete negative tests
Feature: Delete negative tests

    Background: 

        # apiUrl from "karate-config.js"
        * url apiUrl

        # List all issues
        # We list to get the current projectId in the list
        # We list all the issues and then get the projectId and issueId of the first issue.
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id
        * def issueId = response[0].iid

        # List single issue
        # For CRUD path needs to have valid projectId and issueId. So we used if condition.
        # We use above ProjectId and IssueId from all issues list if responseStatus is 200.
        # We use given ProjectId and IssueId if projectId and issueId are invalid and responseStatus is 404.
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then assert responseStatus == 200 || responseStatus == 404
        And if (responseStatus == 404) (projectId == 40851737  &&  issueId == 223 )

    # Attempting to delete a resource that does not exist 
    Scenario: Attempting to delete a resource that does not exist 
    
        # Delete issue 
        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""

        # Attempting to delete the above deleted issue 
        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response ==  {"message":"404 Issue Not Found"}


    # Attempting to delete a non-existent issueId
    Scenario: Attempting to delete a non-existent issueId
        
        # Define a non-existent issueId
        * def currentIssueId = 0
        
        # Attempting to show the defined non-existent issueId in the list
        # Verify that the issue doesn't appear in the list
        Given path "projects",projectId,"issues", currentIssueId
        When method Get
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Not found"}

        # Attempting to delete the defined non-existent issueId in the list
        # Verify that the issue doesn't find in the list
        Given path  "projects", projectId,"issues", currentIssueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Issue Not Found"}

    # Attempting to delete a non-existent projectId
    Scenario: Attempting to delete a non-existent projectId
        
        # Define a non-existent projectId
        * def currentProjectId = 0
        
        # Attempting to show the defined non-existent projectId in the list
        # Verify that the issue doesn't appear in the list
        Given path "projects",currentProjectId ,"issues", issueId
        When method Get
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Project Not Found"}
    
        # Attempting to delete the defined non-existent projectId in the list
        # Verify that the issue doesn't find in the list
        Given path  "projects", currentProjectId ,"issues", issueId
        When method Delete
        Then status 404
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message": "404 Project Not Found"}


    
