
Feature: Get List Issues

    Background: Define baseURL
        * url apiUrl
        # * def jsonSchemaExpected = read("classpath:gitLab/json/listIssuesResponse.json")
       
       
    Scenario: Schema Validation
        Given path 'issues'
        When method Get
       
        Then print response
        # And match each response.iids[0] == jsonSchemaExpected 

    Scenario: Get all issues without filter
        Given path 'issues'
        When method Get
        Then status 200
        
    
    Scenario: Get all issues without filter
        Given params {"iids[]": 3}
        Given path 'issues'
        When method Get
        Then status 200 

    
    # TODO: Scenario Outline: Yapılacak


   
   

      
