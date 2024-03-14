import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jvp_app/model/shared_states.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

class Accelerometer extends StatefulWidget {
  const Accelerometer({super.key});
  @override
  State<Accelerometer> createState() => _AccelerometerState();
}

class _AccelerometerState extends State<Accelerometer> {
  AccelerometerEvent? _currentAccValues;
  double maximumAcceleration = 0;
  double threshold = 0.18;
  bool failed = false;


  // StreamSubscription for accelerometer events
  late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    // Subscribe to accelerometer events
    _accelerometerSubscription = accelerometerEvents.listen((event) {
      setState(() {
        // Update the _accelerometerValues list with the latest event
        _currentAccValues = event;
        print("-------------------------");
        double totalAcceleration = math.sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
        double accWithoutGravity = totalAcceleration - 9.8;
        if(accWithoutGravity > maximumAcceleration) maximumAcceleration = accWithoutGravity;
        print("accWithoutGravity: "+accWithoutGravity.toString());
        print("maximumAcceleration: "+maximumAcceleration.toString());
        print("-------------------------");

        if(threshold < maximumAcceleration){
          failed = true;
          Provider.of<SharedState>(context, listen: false).isAccelerometerValid = false;
          _accelerometerSubscription.cancel();
        }
      });


    });
  }

  @override
  void dispose() {
    // Cancel the accelerometer event subscription to prevent memory leaks
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _currentAccValues != null ?
    failed ?
    Text(
      "Unstable! Try Again!",
      style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w800),
    ) :
    Text(
      "Good! Stable!",
      style: TextStyle(fontSize: 20, color: Colors.lightGreenAccent, fontWeight: FontWeight.w800),
    ) :
    Text(
      'No Accelerometer Data',
      style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w800)
    );
  }
}
