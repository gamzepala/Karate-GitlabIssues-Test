# List all issues
Feature: List all issues

    Background: 

        # apiUrl from "karate-config.js"
        # jsonSchemaExpected : Response schema of list all issues and we read it from listIssuesResponse.json
        * url apiUrl
        * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/listIssuesResponse.json")

    # Schema validation of list all issues
    Scenario: Schema validation of list all issues

        Given path 'issues'
        When method Get
        Then status 200
        * def response  = response[0]
        And match response == "#object"
        And match response == jsonSchemaExpected 

    # List all issues without filter
    Scenario: List all issues without filter

        Given path 'issues'
        When method Get
        Then status 200

    # List all issues  by iid parameter filter
    Scenario: List all issues by iid parameter filter

        # List all issues
        # We list to get the current iid in the list
        # We list all the issues and then get the iid of the first issue
        Given path 'issues'
        When method Get
        Then status 200
        * def iid = response[0].iid
        And assert responseTime < 1000

        # List issues with iid parameter
        # Verify that the issue appears and there is only one issue in the list
        Given param iids[] = iid 
        Given path 'issues'
        When method Get
        Then status 200
        And assert responseTime < 1000
        And match response[1] == "#notpresent"
        






   
   

      
