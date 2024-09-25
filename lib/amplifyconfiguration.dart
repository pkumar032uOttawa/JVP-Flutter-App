const amplifyconfig = '''{
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
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://ij23f4hapvf7lfjudwabmjtnsi.appsync-api.eu-north-1.amazonaws.com/graphql",
                        "Region": "eu-north-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-sft6ykdc4jes5mmnlj6xsaqs3i",
                        "ClientDatabasePrefix": "JVPDatastore_API_KEY"
                    },
                    "JVPDatastore_AWS_IAM": {
                        "ApiUrl": "https://ij23f4hapvf7lfjudwabmjtnsi.appsync-api.eu-north-1.amazonaws.com/graphql",
                        "Region": "eu-north-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "JVPDatastore_AWS_IAM"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "eu-north-1:1aab4e8c-2a4e-4aad-b98c-90d3b0b2ea7a",
                            "Region": "eu-north-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "eu-north-1_lOHuZtJPD",
                        "AppClientId": "dck3dc30fv4girnfdvoq1mjcd",
                        "Region": "eu-north-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "jvpapp59f8b-staging",
                        "Region": "eu-north-1"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "jvpapp59f8b-staging",
                "region": "eu-north-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';
