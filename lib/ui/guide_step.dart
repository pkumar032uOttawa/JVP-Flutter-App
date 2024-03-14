import 'package:flutter/material.dart';
class GuideStep extends StatelessWidget {
  final int stepNumber;
  final String instruction;
  final Widget visualComponent;

  GuideStep({
    required this.stepNumber,
    required this.instruction,
    required this.visualComponent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            child: Text('$stepNumber'),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  instruction,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                    child: visualComponent
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
