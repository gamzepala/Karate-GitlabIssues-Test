function fn(creds) {
    var temp = creds.username + ':' + creds.password;
    var Base64 = Java.type('java.util.Base64');
    var encoded = Base64.getEncoder().encodeToString(temp.toString().getBytes());
    return 'Basic ' + encoded;
  }

  public static String getAccessToken() {
    Response response =
            SerenityRest.given().auth().preemptive().basic(clientId, clientSecret)
                    .formParam("grant_type", "password")
                    .formParam("username", username)
                    .formParam("password", password)
                    .formParam("scope", scope)
                    .when()
                    .post(tokenUri);

    JSONObject jsonObject = new JSONObject(response.getBody().asString());
    String accessToken = jsonObject.get("access_token").toString();

    return accessToken;
}