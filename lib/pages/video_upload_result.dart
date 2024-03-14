import 'package:provider/provider.dart';
import 'package:jvp_app/utils/video_upload.dart';
import 'package:flutter/material.dart';
import 'package:jvp_app/model/shared_states.dart';

class VideoUploadResult extends StatefulWidget {
  final String videoPath;

  VideoUploadResult({required this.videoPath});

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
    String res = await uploadVideo(widget.videoPath, Provider.of<SharedState>(context, listen: false).username);
    setState(() {
      _isUploading = false;
      returnedString = res;
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
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              if (returnedString.startsWith("Nice"))
                Column(
                  children: [
                    Icon(Icons.check_circle_outline, size: 100,
                        color: Colors.green),
                    SizedBox(height: 30,),
                    Text(
                      '$returnedString',
                      style: TextStyle(color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Icon(Icons.no_flash_rounded, size: 100,
                        color: Colors.red),
                    SizedBox(height: 30,),
                    Text(
                      'Failed!  $returnedString',
                      style: TextStyle(color: Colors.red,
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
