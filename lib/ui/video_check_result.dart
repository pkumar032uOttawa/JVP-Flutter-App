import 'package:flutter/material.dart';

class RequirementCard extends StatelessWidget {
  final bool requirementMet;
  final String explanation;

  RequirementCard({required this.requirementMet, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(16.0),
      child: ListTile(
        leading: Icon(
          requirementMet ? Icons.check_circle_outline : Icons.cancel_outlined,
          color: requirementMet ? Colors.green : Colors.red,
          size: 30.0,
        ),
        title: Text(
          explanation,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: requirementMet ? Colors.black : Colors.red,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
    );
  }
}
