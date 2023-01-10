# End-to-End user flow test

Feature: End-to-End user flow test

    # apiUrl from "karate-config.js"
    # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
    # patchIssueRequestBody : For Patch Issue values are read from patchIssueRequest.json 
    # issueRequestBody.title : Random data generated for Issue's Title by Faker
    # issueRequestBody.description : Random data generated for Issue's Description by Faker
    Background: Define URL and 
        * url apiUrl
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
        * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/patchIssueRequest.json")
        * def dataGenerator = Java.type("helpers.DataGenerator")
        * def randomValues = dataGenerator.getRandomIssueValues()
        * set issueRequestBody.title = randomValues.title
        * set issueRequestBody.description = randomValues.description

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
   
    # CRUD in user flow test    
    Scenario: Create - List - Update - List - Delete - List
     
        # Create a new issue
        # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
        # issueId is iid of the created issue
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        * def issueId = response.iid
    
        # List new issue
        # Verify that the new issue appear in the list
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 200
        And match response.title == issueRequestBody.title 

        # Update issue
        # patchIssueRequestBody : title and description is changed  
        Given path "projects", projectId,"issues", issueId
        And request patchIssueRequestBody
        When method Put
        Then status 200
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
    
        # Delete issue
        # Verify delete for updated issue
        Given path "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""
    
        # List delete issue
        # Verify that the deleted issue doesn't appear in the list
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404
        And match response.title == "#notpresent"

