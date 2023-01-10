# Create a new issue
Feature: Create a new issue

    Background: 
        
        # apiUrl from "karate-config.js"
        # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
        # issueRequestBody.title : Random data generated for Issue's Title by Faker
        # issueRequestBody.description : Random data generated for Issue's Description by Faker
        # jsonSchemaExpected : Response schema of new issue
        * url apiUrl
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
        * def dataGenerator = Java.type("helpers.DataGenerator")
        * def randomValues = dataGenerator.getRandomIssueValues()
        * set issueRequestBody.title = randomValues.title
        * set issueRequestBody.description = randomValues.description
        * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/newIssueResponse.json")

        
        # List all issues
        # We list to get the current projectId in the list
        # We list all the issues and then get the projectId and issueId of the first issue.
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id

    # Schema validation of create a new issue
    Scenario: Schema Validation
        
        # Create a new issue 
        # issueRequestBody : For Create Issue values are read from newIssueRequest.json 
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        Then match response == "#object"
        And match response == jsonSchemaExpected
 
    
    # Create a new issue
    Scenario: Create a new issue 

        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        And assert responseTime < 1000
        Then status 201
        And match response.title == issueRequestBody.title 


    # Create different new issues with Scenario Outline
    Scenario Outline: Create different new issues with Scenario Outline

        # Scenario Outline 
        Given path "projects", projectId,"issues"
        And request 
        """
        {
            "author_id" : 12982895,
            "title" : "<title>",
            "description" : "<description>",
            "issue_type" : "issue",
            "assignee_id" : 12982895,
            "created_at" : "2022-03-11T03:45:40Z",
            "due_date" : "2022-03-30T03:45:40Z"
        }
        """
        When method Post
        Then status 400
        And match response == <errorResponse>

        Examples:
        |       title                                 |   description                  |     errorResponse                                  |

        |                                             | Description for Karate test    | {"message":{"title":["can't be blank"]}}|
        |is too long (maximum is 255 characters). too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title. too long title |                                |{ "message": { "title": [ "is too long (maximum is 255 characters)" ] }}|


    
