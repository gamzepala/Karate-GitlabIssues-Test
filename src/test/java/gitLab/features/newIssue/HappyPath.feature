
Feature: New Issue 

    Background: Define URL
        * url apiUrl
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
        * def dataGenerator = Java.type("helpers.DataGenerator")
        * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/newIssueResponse.json")
        * def randomValues = dataGenerator.getRandomIssueValues()
        * set issueRequestBody.title = randomValues.title
        * set issueRequestBody.description = randomValues.description


    Scenario: Schema Validation

        # Lİst issues
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id

        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        And assert responseTime < 1000
        Then match response == "#object"
        And match response == jsonSchemaExpected
 
    

    Scenario: Create a new issue 
    
        # Lİst issues
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id

        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        And assert responseTime < 1000
        Then status 201
        And match response.title == issueRequestBody.title 


    Scenario Outline: Create different new issues

        # Lİst issues
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id

        # Outline 
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
        And assert responseTime < 1000
        Then status 400
        And match response == <errorResponse>

        Examples:
        |       title                  |   description                  |     errorResponse                                  |

        | | Description for Karate test    | {"message":{"title":["can't be blank"]}}|


    
