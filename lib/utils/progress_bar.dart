import 'package:flutter/material.dart';

class CheckpointProgressBar extends StatelessWidget {
  final int currentIndex; // 0-based index, where 0 means the first checkpoint is in progress.
  final int totalCheckpoints = 5; // Total number of checkpoints.
  final List<String> checkpointLabels = [
    "Prepare",
    "Identify",
    "Amplify",
    "Analyze",
    "Complete"
  ];

  CheckpointProgressBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: checkpointLabels
              .map((label) => Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ))
              .toList(),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalCheckpoints * 2 - 1, (index) {
            if (index % 2 == 0) {
              // Checkpoint circles and ticks
              int checkpointIndex = index ~/ 2;
              bool isCompleted = currentIndex > checkpointIndex;
              double size = isCompleted ? 15.0 : 45.0; // Smaller size for completed checkpoints
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.blue : Colors.grey[300],
                ),
                child: Padding(
                  padding: EdgeInsets.all(size / 16),
                  child: isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: size)
                      : Text(
                    (checkpointIndex + 1).toString(),
                    style: TextStyle(color: currentIndex == checkpointIndex ? Colors.blue : Colors.grey[600], fontWeight: FontWeight.w900),
                  ),
                ),
              );
            } else {
              // Lines between checkpoints
              return Expanded(
                child: Container(
                  height: 4.0,
                  color: currentIndex * 2 > index ? Colors.blue : Colors.grey[300],
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}