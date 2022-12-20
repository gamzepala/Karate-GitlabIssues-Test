
Feature: Update issue

    Background:
        * url apiUrl
        * def projectId = 40851737
        * def patchIssueRequestBody = read("classpath:gitLab/json/requestJson/patchIssueRequest.json")

    Scenario: Edit issue

        Given path 'issues'
        When method Get
        Then status 200
        * def issueId = response[1].iid

        Given path "projects", projectId,"issues", issueId
        And request patchIssueRequestBody
        When method Put
        Then status 200
        Then match response == "#object"

       

        


   
    



# TODO: Scenario Outline: Yapılacak
