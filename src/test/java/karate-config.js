function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
  
    // apiUrl : Using Gitlab Base Url
    apiUrl : 'https://gitlab.com/api/v4'
  }
  if (env == 'dev') {

  } else if (env == 'e2e') {

  }

  // accessToken comes from helpers/authentication.feature
  var accessToken = karate.callSingle("classpath:helpers/authentication.feature").accessToken

  // "headers" is used for all http calls 
  karate.configure("headers",{Authorization: "Bearer " + accessToken})
  return config;
}