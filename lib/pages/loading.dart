import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';
import 'package:jvp_app/pages/doctor/main/main_screen_doctor.dart';

import '../provider/user_provider.dart';
import 'home.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<User?> _checkIfUserDetailsAlreadyUpdated(String userId) async{
    final user = await Provider.of<UserProvider>(context, listen: false)
        .getUserByUserId(userId);
    return user;
  }

  Future<void> _updateUserDetails() async {
    final user = await Amplify.Auth.getCurrentUser();
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final email = attributes
        .firstWhere((attribute) =>
    attribute.userAttributeKey.toCognitoUserAttributeKey() ==
        CognitoUserAttributeKey.email)
        .value;
    await Provider.of<UserProvider>(context, listen: false)
        .createUser(user.username, email, user.userId);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(username: ""),
      ),
    );
  }

  void asyncInit() async {
    final user = await Amplify.Auth.getCurrentUser();
    final userDetailsUpdated = await _checkIfUserDetailsAlreadyUpdated(user.userId);
    if(userDetailsUpdated == null){
      await _updateUserDetails();
    }else{
      final bool isDoctor = userDetailsUpdated.userType == UserType.DOCTOR;
      if(isDoctor){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreenDoctor(),
          ),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(username: ""),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/MedicalBackground.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A Video A Day, Keep Heart Concerns Away',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  letterSpacing: 5),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
                Text(
                  '- Everyday Monitoring, Lifesaving Warning!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'CustomFont'),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
