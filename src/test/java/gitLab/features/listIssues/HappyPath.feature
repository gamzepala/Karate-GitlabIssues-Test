
Feature: Get List Issues

    Background: Define baseURL
        * url apiUrl
        * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/listIssuesResponse.json")
       
    Scenario: Schema Validation
        Given path 'issues'
        When method Get
        Then status 200
        * def response  = response[0]
        And match response == "#object"
        And match response == jsonSchemaExpected 

    Scenario: List all issues without filter
        Given path 'issues'
        When method Get
        Then status 200

     
    Scenario: List all issues with filter

        Given path 'issues'
        When method Get
        Then status 200
        * def iid = response[0].iid
        And assert responseTime < 1000

        Given param iids[] = iid 
        Given path 'issues'
        When method Get
        Then status 200
        And assert responseTime < 1000
        And match response[0] == "#object"
        And match response[0] == jsonSchemaExpected 





   
   

      
