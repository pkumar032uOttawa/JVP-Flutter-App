const amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
   "api": {
        "plugins": {
            "awsAPIPlugin": {
                "JVPDatastore": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://ij23f4hapvf7lfjudwabmjtnsi.appsync-api.eu-north-1.amazonaws.com/graphql",
                    "region": "eu-north-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-sft6ykdc4jes5mmnlj6xsaqs3i"
                }
            }
        }
   },
  "auth": {
    "plugins": {
      "awsCognitoAuthPlugin": {
        "IdentityManager": {
          "Default": {}
        },
        "CognitoUserPool": {
          "Default": {
            "PoolId": "eu-north-1_mEK0JQVEM",
            "AppClientId": "7kmfltbf1mibve4tpujt05603r",
            "Region": "eu-north-1"
          }
        },
        "Auth": {
          "Default": {
            "authenticationFlowType": "USER_SRP_AUTH",
            "usernameAttributes": ["email"],
            "signupAttributes": [
              "email", "name"
             ],
            "passwordProtectionSettings": {
                "passwordPolicyMinLength": 8,
                "passwordPolicyCharacters": []
            }
          }
        }
      }
    }
  }
}''';
