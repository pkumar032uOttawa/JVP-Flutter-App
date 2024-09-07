import 'package:flutter/material.dart';
import 'package:jvp_app/model/shared_states.dart';
import 'package:jvp_app/pages/loading.dart';
import 'package:jvp_app/pages/register.dart';
import 'package:jvp_app/pages/reports.dart';
import 'package:jvp_app/pages/login.dart';
import 'package:jvp_app/pages/video_taking.dart';
import 'package:jvp_app/ui/camera.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => SharedState(), child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Authenticator(
      onException: (exception) {
        print('[ERROR]: $exception');
      },
      signUpForm: SignUpForm.custom(fields: [
        SignUpFormField.name(required: true),
        SignUpFormField.username(),
        SignUpFormField.password(),
        SignUpFormField.passwordConfirmation(),
      ]),
      child: MaterialApp(
        builder: Authenticator.builder(),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoadingPage(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/reports': (context) => Reports(),
          '/video_taking': (context) => VideoGuidePage(),
          '/camera': (context) => CameraApp(),
        },
      ),
    );
  }
}

