import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() => runApp(GyroscopeApp());

class GyroscopeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gyroscope Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GyroscopePage(),
    );
  }
}

class GyroscopePage extends StatefulWidget {
  @override
  _GyroscopePageState createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {
  GyroscopeEvent? _gyroscopeEvent;

  @override
  void initState() {
    super.initState();
    // Start listening to gyroscope events
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeEvent = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Data'),
      ),
      body: Center(
        child: Text(
          _gyroscopeEvent != null
              ? 'Gyroscope:\nX: ${_gyroscopeEvent!.x}\nY: ${_gyroscopeEvent!.y}\nZ: ${_gyroscopeEvent!.z}'
              : 'Gyroscope: Not available.',
          style: TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
