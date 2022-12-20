
Feature: Get single list

Background: Define baseURL
    * url apiUrl
    * def jsonSchemaExpected = read("classpath:gitLab/json/responseJson/singleIssueResponse.json")
    * def projectId = 40851737
    * def issueId = 6


Scenario: Schema Validation
    Given path "projects",projectId,"issues",issueId
    When method Get
    Then status 200
    Then match response == "#object"
    And match response == jsonSchemaExpected
    #TODO : Tarihler için ignore olanı değiştir.

Scenario: Get all issues without filter
    Given path "projects", projectId,"issues",issueId
    When method Get
    Then status 200


