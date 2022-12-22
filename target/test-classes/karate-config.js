function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
  
    apiUrl : 'https://gitlab.com/api/v4'
  }
  if (env == 'dev') {

  } else if (env == 'e2e') {

  }

  var accessToken = karate.callSingle("classpath:helpers/authentication.feature").accessToken
  karate.configure("headers",{Authorization: "Bearer " + accessToken})

  
  
  return config;
}