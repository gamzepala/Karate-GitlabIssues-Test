Feature:Negative Tests

Background: Define baseURL
    * url apiUrl


Scenario: Attempting to list a non-existent iids

    Given path 'issues'
    When method Get
    Then status 200
    * def iid = response[0].iid

    Given param iids[] = iid+1
    Given path 'issues'
    When method Get
    Then status 200
    And match response[0] ==  "#notpresent"


# Scenario: Content-Type != application/json

#     Given path 'issues'
#     And header "a"
#     When method Get
#     Then status 200
