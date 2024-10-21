import 'package:flutter/material.dart';
import 'package:jvp_app/ui/profile.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Colors.cyan,
        title: Text(
          _selectedIndex == 0? "Reports":"Profile",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFFAC9292),
        backgroundColor: Colors.cyan,
        elevation: 10.0,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 12,
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(context, Icons.upload, 'Upload Video', () {
              Navigator.pushNamed(context, "/video_taking");
            }),
            SizedBox(height: 20),
            _buildButton(context, Icons.report, 'View Reports', () {
              Navigator.pushNamed(context, "/reports");
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, IconData icon, String text,
      VoidCallback onPressed) {
    double width = MediaQuery.of(context).size.width * 0.8; // Adjusted width
    double height = MediaQuery.of(context).size.height * 0.12; // Adjusted height

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: width,
      height: height,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double fontSize = constraints.maxWidth * 0.08;
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.white,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                textStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(icon, size: fontSize), // Adjusted icon size
                  SizedBox(width: 10),
                  Text(text),
                ],
              ),
            );
          }),
    );
  }
}
