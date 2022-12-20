

Feature:

    Background:
        * url authURL = "https://gitlab.com/oauth/token"
    Scenario: Verify the user details using OAuth2 Implicit grant type

    * form field grant_type = 'password'
    * form field username = 'gamze.dedepala'
    * form field password = 'Glimportant123'
    * form field client_id = '942ddb65a0409c4ac3a4f82d542e58144427c346073c70e9e9fc8a14954347fc'
    * form field client_secret = 'd469f4b91ec96902e9538c98a808d55cbff817053c3d7f4908a50b1a60355c68'
    * form field scope = 'api'
    * method post
    * status 200
    * print response
    * def accessToken = response.access_token
    