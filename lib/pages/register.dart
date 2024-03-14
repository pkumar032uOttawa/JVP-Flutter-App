import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jvp_app/utils/dialog.dart';
import 'package:jvp_app/utils/illumination_check.dart';
import 'dart:convert'; // For json encoding/decoding

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Color _skinColor = Color(0xFFF5F0EC); // Default skin color
  bool _isLoading = false; // Initial state of the loading indicator

  void _register() async {
    if(_usernameController.text == "" || _passwordController.text == ""){
      showCustomizedDialog('Register Failed', 'Empty Username or Password.', context);
      return;
    }
    setState(() {
      _isLoading = true;
    });

    // Replace with your server endpoint
    var url = Uri.parse('https://jvp.cepheus0.com:2531/register');

    double brightness = (_skinColor.red + _skinColor.green + _skinColor.blue) / 3;
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'username': _usernameController.text,
          'password': _passwordController.text,
          'skinColor': brightness,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Register successfully!"),
            duration: Duration(seconds: 2), // Show the SnackBar for two seconds
          ),
        );
        Navigator.pop(context);
      } else {
        // Handle errors or unsuccessful registration
        if(response.statusCode == 404){
          showCustomizedDialog('Register Failed', 'Server not ready', context);
        }
        else if(response.statusCode == 400){
          showCustomizedDialog('Register Failed', 'Username is already taken', context);
        }
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  void _pickColor(BuildContext context) {
    // Define a list of skin tone colors
    final List<Color> skinTones = [
      Color(0xFFF5F0EC),
      Color(0xFFFFDBAC), // Lightest
      Color(0xFFECC8AF),
      Color(0xFFE0B49A),
      Color(0xFFD29B84),
      Color(0xFFC58F72),
      Color(0xFFA7795D),
      Color(0xFF906B4F),
      Color(0xFF805D43),
      Color(0xFF704F38),
      Color(0xFF603F2B),
      Color(0xFF4B2F20), // Darker skin tone
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick your skin color'),
          content: SingleChildScrollView(
            child: Wrap(
              children: skinTones.map((Color color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _skinColor = color;
                      print("!!!!!! Selected skin color:"+((_skinColor.red + _skinColor.green + _skinColor.blue) / 3).toString());
                      print("!!!!!! threshold: "+(calculateIlluminationThreshold((_skinColor.red + _skinColor.green + _skinColor.blue) / 3)).toString());
                      Navigator.of(context).pop(); // Dismiss the dialog on selection
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                  'New User Register',
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
                      hintText: 'Pick your username',
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
                      hintText: 'Choose your password',
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
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(2), // Add padding around the icon
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4), // Make the container slightly rounded
                      ),
                      child: Icon(
                        Icons.person, // Use a person icon or any other human icon
                        color: _skinColor, // Icon color
                      ),
                    ),
                    title: Text('Pick your skin color', style: TextStyle(color: Colors.white)),
                    onTap: () => _pickColor(context),
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('REGISTER'),
                )
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
