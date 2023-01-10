# Create a new issue negative test
Feature: Create a new issue negative tests

    Background: 

        # apiUrl from "karate-config.js"
        # issueEmptyRequestBody : For Create Issue values are read from emptyNewIssueRequest.json 
        # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
        * url apiUrl
        * def issueEmptyRequestBody = read("classpath:gitLab/json/requestJson/emptyNewIssueRequest.json")
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")

          # List all issues
        # We list to get the current projectId in the list
        # We list all the issues and then get the projectId and issueId of the first issue.
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id

    # Empty payload request for create a new issue
    Scenario: Empty payload request for create a new issue

        Given path "projects", projectId,"issues"
        And request issueEmptyRequestBody
        When method Post
        Then status 400
        Then match response == {"error": "issue_type does not have a valid value"}

    
    # Attempting to create a new issue that  a title is empty
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
        

 




    
