

Feature:

    Background:
        * url authURL = "https://gitlab.com/oauth/token"
    Scenario: Verify the user details using OAuth2 Implicit grant type

        # * def client_id = java.lang.System.getenv('CLIENT_ID');
        # * def client_secret = java.lang.System.getenv('CLIENT_SECRET');
        # * def gitlab_password = java.lang.System.getenv('GITLAB_PASSWORD');
        # * def gitlab_user = java.lang.System.getenv('GITLAB_USERNAME');



        # * form field grant_type = 'password'
        # * form field username = gitlab_user
        # * form field password = gitlab_password
        # * form field client_id = client_id
        # * form field client_secret = client_secret



        * form field grant_type = 'password'
        * form field username = "gamze.dedepala"
        * form field password = "Glimportant123"
        * form field client_id = "942ddb65a0409c4ac3a4f82d542e58144427c346073c70e9e9fc8a14954347fc"
        * form field client_secret = "d469f4b91ec96902e9538c98a808d55cbff817053c3d7f4908a50b1a60355c68"
        * form field scope = 'api'
        * method post
        * status 200
        * print response
        * def accessToken = response.access_token
    