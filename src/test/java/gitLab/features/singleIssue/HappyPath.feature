# List single issue
Feature: List single issue

    Background: 
     
        # apiUrl from "karate-config.js"
        # jsonSchemaExpected : Response schema of list single issue and we read it from singleIssueResponse.json
        * url apiUrl
        * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/singleIssueResponse.json")

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
   
    # Schema validation of list single issue
    Scenario: Schema validation of list single issue
        

        Given path "projects",projectId,"issues",issueId
        When method Get
        Then status 200
        Then match response == "#object"
        And match response == jsonSchemaExpected


    # List single issue
    Scenario: # List single issue 

        # Verify that the issue appears and there is only one issue in the list
        Given path "projects", projectId,"issues",issueId
        When method Get
        Then status 200
        And assert responseTime < 1000



