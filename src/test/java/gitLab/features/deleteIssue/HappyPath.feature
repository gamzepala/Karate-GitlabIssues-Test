# Deleting a issue from the existing list and deleting a newly created issue
Feature: Deleting a issue from the existing list and deleting a newly created issue

    Background: 

        # apiUrl from "karate-config.js"
        # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
        # issueRequestBody.title : Random data generated for Issue's Title by Faker
        # issueRequestBody.description : Random data generated for Issue's Description by Faker
        * url apiUrl
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
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
        * def projectId = response[1].project_id
        * def issueId = response[1].iid

        # List single issue
        # For CRUD path needs to have valid projectId and issueId. So we used if condition.
        # We use above ProjectId and IssueId from all issues list if responseStatus is 200.
        # We use given ProjectId and IssueId if projectId and issueId are invalid and responseStatus is 404.
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then assert responseStatus == 200 || responseStatus == 404
        And if (responseStatus == 404) (projectId == 40851737  &&  issueId == 223 )


    Scenario: Deleting a issue from the existing list

        # Delete issue 
        # Verify that delete the exist issueId in the list
        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""
    

        # List delete issue
        # Verify that the deleted issue doesn't appear in the list
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404
        And match response.title == "#notpresent"


    Scenario: Deleting a newly created issue

        # Create issue
        # Verify that create issue with defined projectId
        # Response is an example value
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        * def issueId = response.iid
        And assert responseTime < 1000

        # List new issue
        # Verify that shown the new created issueId in the list
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 200
        And match response.title == issueRequestBody.title    

        # Delete new created issue
        # Verify that delete the new created issueId in the list
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

      



    
