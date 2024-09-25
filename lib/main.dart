import 'package:flutter/material.dart';
import 'package:jvp_app/pages/loading.dart';
import 'package:jvp_app/pages/reports.dart';
import 'package:jvp_app/pages/video_taking.dart';
import 'package:jvp_app/provider/shared_states.dart';
import 'package:jvp_app/provider/user_provider.dart';
import 'package:jvp_app/ui/camera.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:google_fonts/google_fonts.dart';
// ##To generate models use command amplify codegen models

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SharedState()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
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
      final storage = AmplifyStorageS3();
      final auth = AmplifyAuthCognito();
      final provider = ModelProvider();
      final dataStorePlugin = AmplifyDataStore(modelProvider: provider);
      await Amplify.addPlugins([auth, storage,dataStorePlugin]);
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
      signUpForm: SignUpForm.custom(
        fields: [
          // SignUpFormField.name(required: true),
          SignUpFormField.email(required: true),
          SignUpFormField.username(),
          SignUpFormField.password(),
          SignUpFormField.passwordConfirmation(),
        ],
      ),
      child: MaterialApp(
        builder: Authenticator.builder(),
        initialRoute: '/',
        theme: ThemeData(
          // Applying the Juanito font to the app's text theme
          textTheme: GoogleFonts.nunitoTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoadingPage(),
          '/reports': (context) => Reports(),
          '/video_taking': (context) => VideoGuidePage(),
          '/camera': (context) => CameraApp(),
        },
      ),
    );
  }
}
