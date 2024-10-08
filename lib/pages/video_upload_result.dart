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
    // String videoUrl =
    //     "https://jvpapp59f8b-staging.s3.eu-north-1.amazonaws.com/upload/file.jpeg?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEMT%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCmV1LW5vcnRoLTEiSDBGAiEAqbCS%2B6dFAqNhLQrEU5r4pTZGz33DmrWGo0W3XvcCpV0CIQD2EYxbdC4WfeB%2Fqxd%2FXGNKhjGzoD8Ix6HP1SvurJZ81yrkAggeEAAaDDUxNTk2NjQ5MjQ4MyIMpPqiVDRV609F5PEYKsECVC0jdqHmhzkBZPVHSYqabLTBKqvL20PHwiSesZhFDbbBAJnC6jnWYEAEXLjq4EI%2FTZHtLsdZUdJqJfuaGpwy40uV4383zrgj4mcgoFTOZU0evvxWrNS6Pqefu5vcBWbWPU4xpIR2cHngJdEPF7pIVifWK8t3ds%2B7Ti1ZyWb%2BKI1govOb8UxMJ34tLTZMCxGwnNaJ0SIHluBwgNJ5d91%2Bg645w%2B4KrNcReqCRAXDLl3xOsxcZbc9JR496vKvHPETbexjF4xGMohVpCTHIk499o21NfDrjMVxAfQelKW2wZ%2BnW%2FoVfbknqKeqUDO0tvywjvieVBdkV61F%2FyK94o%2BZ7e8PIQxDAkuiSy7LBqB0E5PF1qQ81X4pN6Ft5peq9PJqAU4HXVr3wWdlH4Rj%2F059LScW%2FBIGNOp6xQI7HIQBfcEMcMJjpi7gGOrICYv6%2Fw4QX2%2Bh8vfSR3bQhj91DrGRHy3z%2FMqVCz4Ld3uJYKY9OZoy8NpPvKSzTkY%2FDLMVz60lm937vvC5ulZ4NqtWlArZsRPiIgWMGu4AZieo5K3vhHlAg0EqwEJHxc3fj1QIZRojhsUkmMIdi1V2GkMq7jrU8hTjB4WZ2AhiLRs4%2BULBYhgHtK8cZdEs8TYDLi8iqAfHtGwbgs511eGRt8TL0yQ6%2BucACodKfoXQVJIf%2FMBYQA%2FdHBzoAuXip2PVKW8Va1zY%2B%2Fd6hco2qMWLbT084YnUycF9FVkGDvl7yMiVt82p5wDgZRFb4ykUmoJOxa0iuEL4e0lhIoJCHe6eHoHShQbG%2B0Lqb2OO2c3bMV1OQ1ck%2F6LxvklC%2FvP%2B2VCLB6vcIoi673B4YGwHvI3JJSN9n&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20241006T211214Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAXQIP735B764EQUUK%2F20241006%2Feu-north-1%2Fs3%2Faws4_request&X-Amz-Signature=162f351e20fef1d88ec19c85dcdf34e26f7caacb4b856d32603e3789ddd36da1";
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
