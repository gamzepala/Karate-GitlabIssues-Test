

Feature: User Flow Test

    Background: Define URL
    * url apiUrl
    * def projectId = 40851737
    * def issueRequestBody = read("classpath:gitLab/json/requestJson/newIssueRequest.json")
    * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/patchIssueRequest.json")
    * def dataGenerator = Java.type("helpers.DataGenerator")
    * def randomValues = dataGenerator.getRandomIssueValues()
    * set issueRequestBody.title = randomValues.title
    * set issueRequestBody.description = randomValues.description
  
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
    
        # Get delete issue
        Given path "projects", projectId,"issues", issueId
        When method Get
        Then status 404
        And match response.title == "#notpresent"


#TODO schema 
#TODO generic match
#TODO outline
#TODO  retry and sleep
#TODO gatling


# Negative tests with valid input
# Examples: 
# Attempting to create a resource with a name that already exists
# Attempting to delete a resource that does not exist 
# Attempting to update a resource with illegal valid data(Rename it to an existing name)
# Attempting to delete a resource without 

# Negative tests with invalid input
# Examples: 
# Missing or invalid authorisation token
# Missing required parameters-
# Invalid path or query parameters
# Payload with invalid model(Schema violation)
# Payload with incomplete mode(Missing fields)
# Invalid values in headers
# Unsupported metho