import 'package:flutter/material.dart';
import 'package:jvp_app/utils/websocket.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WebSocketConnection webSocketConnection = new WebSocketConnection(3777);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('WebSocket Demo'),
        ),
        body: SizedBox()
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
