Feature:Negative Tests

Background: Define URL
    * url apiUrl
    * def issueRequestBody = read("classpath:gitLab/json/requestJson/emptyNewIssueRequest.json")

    Scenario: Empty payload request

        # Lİst issues
        Given path 'issues'
        When method Get
        Then status 200
        * def projectId = response[0].project_id

        Given path "projects", projectId,"issues"
        And request issueRequestBody
        When method Post
        Then status 400
        Then match response == {"error": "issue_type does not have a valid value"}
        

 




    
