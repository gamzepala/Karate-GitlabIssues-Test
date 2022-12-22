

Feature: New Issue 

    Background: Define URL
        * url apiUrl
        * def projectId = 40851737
        * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
        * def dataGenerator = Java.type("helpers.DataGenerator")
        * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/newIssueResponse.json")
        * def randomValues = dataGenerator.getRandomIssueValues()
        * set issueRequestBody.title = randomValues.title
        * set issueRequestBody.description = randomValues.description


    Scenario: Schema Validation
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        Then match response == "#object"
        And match response == jsonSchemaExpected
 
    

    Scenario: Create a new issue 
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        And match response.title == issueRequestBody.title 



    
