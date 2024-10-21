import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';
import 'package:jvp_app/provider/admin_provider.dart';
import 'package:provider/provider.dart';

class ReportFeedback extends StatefulWidget {
  final UserReport userReport;

  const ReportFeedback({
    super.key,
    required this.userReport,
  });

  @override
  State<ReportFeedback> createState() => _ReportFeedbackState();
}

class _ReportFeedbackState extends State<ReportFeedback> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  bool _loading = false;

  Future<void> _submitFeedback(String feedback) async {
    _setLoading();
    await Provider.of<AdminProvider>(context, listen: false).submitFeedback(
      feedback,
      widget.userReport.id,
    );
    _setLoading();
  }

  _setLoading() {
    setState(() {
      _loading = !_loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                hintText: 'Feedback',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _submitFeedback(_feedbackController.text);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.cyan, // Customize the button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
