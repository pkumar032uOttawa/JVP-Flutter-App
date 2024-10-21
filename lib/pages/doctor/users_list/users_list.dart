import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jvp_app/provider/admin_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/User.dart';
import 'package:provider/provider.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> _users = [];

  Future<List<User>?> _getUsers() async {
    final users =
        await Provider.of<AdminProvider>(context, listen: false).getAllUsers();
    _users = users!;
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Manage Users",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        elevation: 4.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: FutureBuilder<List<User>?>(
        future: _getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final item = _users[index];
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "User - ${item.email}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),

                              ElevatedButton(
                                onPressed: () {
                                  // Handle 'Manage Reports Submitted' action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                  backgroundColor: Colors.cyan,
                                  // Customize button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Manage Reports Submitted'.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              SizedBox(height: 16),
                              // Adds space between the two buttons

                              ElevatedButton(
                                onPressed: () {
                                  // Handle 'Make Admin' action
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 16.0),
                                  backgroundColor: Colors.cyan,
                                  // Customize button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'Make Admin'.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
