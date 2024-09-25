import 'package:flutter/material.dart';
import 'package:jvp_app/pages/video_upload_result.dart';

class HeartCareScreening extends StatefulWidget {
  final String videoPath;

  HeartCareScreening({required this.videoPath});

  @override
  _HeartCareScreeningState createState() => _HeartCareScreeningState();
}

class _HeartCareScreeningState extends State<HeartCareScreening> {
  Map<String, bool?> answers = {
    'Do you have heart disease?': null,
    'Have you ever had a stroke?': null,
    'Do you experience chest pains frequently?': null,
    'Do you suffer from high blood pressure?': null,
    'Is there a family history of heart disease?': null,
    'Do you smoke?': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Questionnaire',),
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        children: [
          ...answers.keys.map((String question) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      question,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make text bold
                        fontSize: 17, // Increase font size
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<bool>(
                        value: true,
                        groupValue: answers[question],
                        onChanged: (bool? value) {
                          setState(() {
                            answers[question] = value;
                          });
                        },
                      ),
                      Text('Yes'),
                      Radio<bool>(
                        value: false,
                        groupValue: answers[question],
                        onChanged: (bool? value) {
                          setState(() {
                            answers[question] = value;
                          });
                        },
                      ),
                      Text('No'),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                print(answers);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoUploadResult(videoPath: widget.videoPath, answers: answers,),
                  ),
                );
              },
              child: Text('Submit Answers and Upload Video'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button color
                foregroundColor: Colors.white, // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
