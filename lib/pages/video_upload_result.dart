import 'package:jvp_app/models/ModelProvider.dart';
import 'package:jvp_app/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:jvp_app/provider/shared_states.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class VideoUploadResult extends StatefulWidget {
  final String videoPath;
  final Map<String, bool?> answers;

  VideoUploadResult({required this.videoPath, required this.answers});

  @override
  State<VideoUploadResult> createState() => _VideoUploadResultState();
}

class _VideoUploadResultState extends State<VideoUploadResult> {
  bool _isUploading = true;
  String returnedString = '';

  @override
  void initState() {
    _uploadVideo();
    super.initState();
  }

  void _uploadVideo() async {
    final user = await Amplify.Auth.getCurrentUser();
    String? videoUrl = await Provider.of<UserProvider>(context, listen: false)
        .uploadIOFile((widget.videoPath));
    if (videoUrl.isNotEmpty || videoUrl != null) {
      final map = widget.answers;
      final skinColor =
          Provider.of<SharedState>(context, listen: false).skinBrightness;
      final userReport = UserReport(
        userId: user.userId,
        status: PostStatus.ACTIVE,
        videoUrl: videoUrl,
        heartDisease: map["Do you have heart disease?"] ?? false,
        everHadAStroke: map["Have you ever had a stroke?"] ?? false,
        experienceChestPainsFrequently:
            map["Do you experience chest pains frequently?"] ?? false,
        sufferHighBloodPressure:
            map["Do you suffer from high blood pressure?"] ?? false,
        familyHistoryHeartDisease:
            map["Is there a family history of heart disease?"] ?? false,
        skinColor: skinColor.toString(),
        smoke: map["Do you smoke?"] ?? false,
      );
      Provider.of<UserProvider>(context, listen: false)
          .createUserReport(userReport);
    }
    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload Result'),
      ),
      body: Center(
        child: _isUploading
            ? CircularProgressIndicator() // Show loading indicator while video is loading
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Icon(Icons.check_circle_outline,
                          size: 100, color: Colors.green),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '$returnedString',
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
