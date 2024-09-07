import 'package:flutter/material.dart';

import 'home.dart';


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
  void asyncInit() async {
    await Future.delayed(Duration(seconds: 2)); // Example delay
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(username: ""),
      ),
    );
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
                style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'CustomFont', letterSpacing: 5),
              ),
              SizedBox(height: 30.0,),
              Row(
                children: [
                  Expanded(flex: 4, child: SizedBox(),),
                  Text(
                    '- Everyday Monitoring, Lifesaving Warning!',
                    style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'CustomFont'),
                  ),
                  Expanded(flex: 1, child: SizedBox(),),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
