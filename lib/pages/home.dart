import 'package:flutter/material.dart';
import 'package:jvp_app/ui/profile.dart';
import 'package:jvp_app/utils/websocket.dart';

class Home extends StatefulWidget {
  final String username;
  Home({Key? key, required this.username}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WebSocketConnection webSocketConnection = new WebSocketConnection(widget.username);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      ReportsPage(),
      ViewUserAttributesScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_chart),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildButton(context, Icons.upload, 'Upload Video', () {
            Navigator.pushNamed(context, "/video_taking");
          }),
          SizedBox(height: 20),
          _buildButton(context, Icons.report, 'View Reports', () {
            // Action for View Reports
            Navigator.pushNamed(context, "/reports");
          }),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String text, VoidCallback onPressed) {
    double width = MediaQuery.of(context).size.width * 0.6;
    double height = MediaQuery.of(context).size.height * 0.25;  // Calculate height based on the desired ratio

    return Container(
      width: width,
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double fontSize = constraints.maxWidth * 0.1;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Background color
              foregroundColor: Colors.white, // Text Color (Foreground color)
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              textStyle: TextStyle(
                fontSize: fontSize,  // Increased font size
                fontWeight: FontWeight.bold,  // Bold text
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: fontSize),  // Optionally adjust icon size
                SizedBox(width: 10),
                Text(text),
              ],
            ),
          );
        }
      ),
    );
  }
}

