import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Space items evenly in the column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileItem(tag: 'Name', content: 'John Doe'),
            ProfileItem(tag: 'Phone Number', content: '+123456789'),
            ProfileItem(tag: 'ID', content: '1234567890'),
            ProfileItem(tag: 'Status', content: 'Active'),
            ProfileItem(tag: 'Age', content: '30'),
          ],
        ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String tag;
  final String content;
  final TextStyle tagStyle = TextStyle(
    color: Colors.deepOrange,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  final TextStyle contentStyle = TextStyle(
  color: Colors.black87,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.underline,
  fontSize: 16,
  );

  ProfileItem({required this.tag, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 1, 0, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2, // Adjust the flex to control the space ratio between tag and content
                child: Text('$tag:', style: tagStyle),
              ),
              Expanded(
                flex: 3, // Adjust the flex to control the space ratio between tag and content
                child: Text(content, style: contentStyle),
              ),
            ],
          ),
          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
