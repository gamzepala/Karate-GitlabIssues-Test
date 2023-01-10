# Update issue
Feature: Update issue

    Background:

        # apiUrl from "karate-config.js"
        # patchIssueRequestBody : For Patch Issue values are read from patchIssueRequest.json 
        * url apiUrl
        * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/patchIssueRequest.json")
        
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


    # Update issue
    Scenario: Update issue

        # patchIssueRequestBody : title and description is changed  
        Given path "projects", projectId,"issues", issueId
        And request patchIssueRequestBody
        When method Put
        Then status 200
        And assert responseTime < 1000
        Then match response == "#object"
        * def updatedTitle = response.title
        * def updatedDescription = response.description
       
        # List updated issue
        # Verify title and description change for this issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 200
        And match response.title == updatedTitle
        And match response.description == updatedDescription

       
