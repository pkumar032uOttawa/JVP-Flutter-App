import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jvp_app/model/shared_states.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/profile.png'), // Replace with your image URL
              ),
            ),
            SizedBox(height: 20),
            ProfileItem(tag: 'Name', content: Provider.of<SharedState>(context, listen: false).username),
            ProfileItem(tag: 'Email', content: 'johndoe@example.com'),
            ProfileItem(tag: 'Skin Brightness', content: Provider.of<SharedState>(context, listen: false).skinBrightness.toString()),
            ProfileItem(tag: 'Reports', content: '4'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  foregroundColor: Colors.white, // Text color
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text('Logout'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Text color
                ),
              ),
            ),
          ],
        ),
      );
  }
}

class ProfileItem extends StatelessWidget {
  final String tag;
  final String content;

  ProfileItem({required this.tag, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1, // Adjust the flex to control the space ratio between tag and content
            child: Text(
              '$tag:',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 2, // Adjust the flex to control the space ratio between tag and content
            child: Text(
              content,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
