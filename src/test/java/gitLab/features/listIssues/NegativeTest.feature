
# List all issues negative test
Feature:List all issues negative test

    Background: 

        # apiUrl from "karate-config.js"
        * url apiUrl


    # Attempting to authenticate with non exist accessToken
    Scenario: Attempting to authenticate with non exist accessToken

        # Non exist token is defined for headers-Authorization.
        * configure headers = { Authorization: "Bearer 123453948858ldjdo" }
        Given path 'issues'
        When method Get
        Then status 401
        And match response == "#present"
        And match response == "#notnull"
        And match response == {"message":"401 Unauthorized"}
  





