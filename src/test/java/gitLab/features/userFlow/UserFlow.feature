
Feature: User Flow Test

    Background: Define URL
    * url apiUrl
    * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
    * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/patchIssueRequest.json")
    * def dataGenerator = Java.type("helpers.DataGenerator")
    * def randomValues = dataGenerator.getRandomIssueValues()
    * set issueRequestBody.title = randomValues.title
    * set issueRequestBody.description = randomValues.description

    # Lİst issues
    Given path 'issues'
    When method Get
    Then status 200
    * def projectId = response[0].project_id

  
    Scenario: Create - List - Update - List - Delete - List
     
        # Create issue
        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 201
        * def issueId = response.iid
    
        # List new issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 200
        And match response.title == issueRequestBody.title 

        # Update issue
        Given path "projects", projectId,"issues", issueId
        And request patchIssueRequestBody
        When method Put
        Then status 200
        Then match response == "#object"
        * def updatedTitle = response.title
        * def updatedDescription = response.description
         #TODO generic match

        # Liste updated issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 200
        And match response.title == updatedTitle
        And match response.description == updatedDescription
    
        # Delete issue
        Given path "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""
    
        # List delete issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404
        And match response.title == "#notpresent"

