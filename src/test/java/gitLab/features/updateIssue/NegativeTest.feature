# Update issue negative test
Feature: Update issue negative test

Background:

    # apiUrl from "karate-config.js"
    # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
    # emptyTitlePatchIssueRequest : Title is empty in request read from emptyTitlePatchIssueRequest.json
    * url apiUrl
    * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
    * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/emptyTitlePatchIssueRequest.json")
    
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
    And if (responseStatus == 404) (projectId == 40851737  &&  issueId == 223)

    # Update issue
    Scenario: Update issue

        # Create a new issue
        # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
        # issueId is iid of the created issue
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        * def issueId = response.iid
        * def title = response.title
        * def description = response.description

        # patchIssueRequestBody : The title is empty from emptyTitlePatchIssueRequest.json
        # Verify that it haven't updated because of title is empty
        Given path "projects", projectId,"issues", issueId
        And request patchIssueRequestBody 
        When method Put
        Then status 400
        And assert responseTime < 1000
        Then match response == "#object"
        Then match response == { "message": { "title": [  "can't be blank"  ]  }}
      
    
        # List don't updated this issue
        # Verify that title and description haven't changed for this issue and are the same as create new issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 200
        And match response.title == title
        And match response.description == description

   
