import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jvp_app/model/shared_states.dart';
import 'package:jvp_app/pages/home.dart';
import 'package:jvp_app/utils/dialog.dart';
import 'package:provider/provider.dart';
import 'dart:convert'; // For json encoding/decoding

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Initial state of the loading indicator

  void _login() async {
    if(_usernameController.text == "" || _passwordController.text == ""){
      showCustomizedDialog('Login Failed', 'Empty Username or Password.', context);
      return;
    }
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // Replace with your server endpoint
    var url = Uri.parse('https://jvp.cepheus0.com:2531/login');

    try {
      var response = await http.post(
        url,
        body: json.encode({
          'username': _usernameController.text,
          'password': _passwordController.text,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        Provider.of<SharedState>(context, listen: false).username = result["username"];
        Provider.of<SharedState>(context, listen: false).skinBrightness = result["skin"];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(username: result["username"]),
          ),
        );
      } else if (response.statusCode == 401) {
        showCustomizedDialog('Error', 'Wrong Password or Username.', context);
      }
    } catch (e) {
      print(e.toString());
      showCustomizedDialog('Error', 'Unable to connect to the server.', context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/loginBackground.png', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),
                Text(
                  'Welcome! One More Step!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your username here',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password here',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      // Handle forgot password tap
                    },
                    child: Text(
                      'Forget Password? Click here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('LOGIN'),
                    ),
                    SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Handle sign up
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('NEW USER'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
