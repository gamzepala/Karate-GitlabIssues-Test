@debug 
Feature: Delete Issue 

Background: Define URL
    * url apiUrl
    * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
    * def dataGenerator = Java.type("helpers.DataGenerator")
    * def randomValues = dataGenerator.getRandomIssueValues()
    * set issueRequestBody.title = randomValues.title
    * set issueRequestBody.description = randomValues.description

    Scenario: Delete issue
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id
        * def issueId = response[0].iid

        Given path  "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""
        And assert responseTime < 1000

        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404


    Scenario: Create and Delete issue
       # Lİst issues
       Given path 'issues'
       When method Get
       Then status 200
       * def projectId = response[0].project_id

       # Create issue
       Given path "projects", projectId,"issues"
       And request issueRequestBody
       When method Post
       Then status 201
       * def issueId = response.iid
       And assert responseTime < 1000

       # List new issue
       Given path "projects", projectId,"issues", issueId
       When method Get
       Then status 200
       And match response.title == issueRequestBody.title    

        # Delete issue
        Given path "projects", projectId,"issues", issueId
        When method Delete
        Then status 204
        And match response == ""
        And assert responseTime < 1000
      
        # List delete issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404
        And match response.title == "#notpresent"

      



    
