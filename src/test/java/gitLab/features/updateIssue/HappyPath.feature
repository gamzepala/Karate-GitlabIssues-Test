
Feature: Update issue

    Background:
        * url apiUrl
        * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/patchIssueRequest.json")

    Scenario: Edit issue

        Given path 'issues'
        When method Get
        Then status 200
        And assert responseTime < 1000
        * def projectId = response[0].project_id
        * def issueId = response[0].iid

        Given path "projects", projectId,"issues", issueId
        And request patchIssueRequestBody
        When method Put
        Then status 200
        And assert responseTime < 1000
        Then match response == "#object"

       

        


   
    



# TODO: Scenario Outline: Yapılacak
