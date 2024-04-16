import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jvp_app/pages/video_checking.dart';
import 'package:jvp_app/ui/video_player.dart';
import 'package:jvp_app/ui/guide_step.dart';
import 'package:jvp_app/utils/delete_file.dart';
import 'package:provider/provider.dart';
import 'package:jvp_app/model/shared_states.dart';

class VideoGuidePage extends StatefulWidget {
  @override
  State<VideoGuidePage> createState() => _VideoGuidePageState();
}

class _VideoGuidePageState extends State<VideoGuidePage> {
  final ImagePicker _picker = ImagePicker();
  bool closeVideos = false;
  String? _videoPath;
  @override
  void initState() {
    super.initState();
    deleteCacheMp4Files();
  }

  Future<void> _takeVideo(BuildContext context) async {
    final XFile? recordedVideo = await Navigator.pushNamed(context, '/camera') as XFile?;
    if (recordedVideo != null) {
      // Do something with the recorded video file, e.g., display it or upload it
      print('Video path: ${recordedVideo.path}');
      setState(() {
        _videoPath = recordedVideo.path;
      });
    }
  }

  Future<void> _selectFromAlbum(BuildContext context) async {
    Provider.of<SharedState>(context, listen: false).isAccelerometerValid = true;
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      print('Video path: ${video.path}');
      setState(() {
        _videoPath = video.path;
      });
    }
  }
  @override
  void dispose() {
    print("!!!!!!! disposing video_taking page");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Taking Guideline'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GuideStep(
              stepNumber: 1,
              instruction: 'Find support for back and neck to avoid straining your neck muscles',
              visualComponent: Container(
                height: 300,
                width: 500,// Set a fixed height for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/Step1.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            GuideStep(
              stepNumber: 2,
              instruction: 'Remove anything that covers the neck, the clavicle, and the right ear, such as hair and accessories',
              visualComponent: Container(
                height: 300,
                width: 500,// Set a fixed height for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/Step2.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            GuideStep(
              stepNumber: 3,
              instruction: "Hold the phone in your right hand, rest your elbow for stability, and lean back. Adjust until your ear, clavicle, and neck are in view, then focus the camera on your neck's base",
              visualComponent: Container(
                height: 300,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/Step3.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            GuideStep(
              stepNumber: 4,
              instruction: 'Lean back, turn your head left by 30 degrees with your right hand stable. Adjust your collar to show your clavicle if needed, then start recording. Stay still and avoid any moving, swallowing, chewing, caughing, clenching, and speaking for 30 seconds',
              visualComponent: Container(
                height: 300,
                width: 500,// Set a fixed height for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/Step4.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            GuideStep(
              stepNumber: 4,
              instruction: 'Stop the recording after 30 seconds',
              visualComponent: Container(
                height: 300,
                width: 500,// Set a fixed height for the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/Step5.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            closeVideos==false ? GuideStep(
              stepNumber: 5,
              instruction: 'Sample video should look like this',
              visualComponent: VideoPlayerWidget(videoLocation: 'assets/tutorial.mp4'),
            ):SizedBox(),

            GuideStep(
              stepNumber: 6,
              instruction: _videoPath==null ? 'Now take your own video!' : 'Review your video to ensure it meets our requirements',
              visualComponent: _videoPath==null
                  ?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text('Take a Video'),
                              onTap: () {
                                Navigator.pop(context); // Close the BottomSheet
                                _takeVideo(context);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_album),
                              title: Text('Select from Album'),
                              onTap: () {
                                Navigator.pop(context); // Close the BottomSheet
                                _selectFromAlbum(context); // Then perform the _selectFromAlbum action
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // Button color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Start Recording',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ) :
              Column(
                children: [
                  closeVideos==false?VideoPlayerWidget(videoLocation: _videoPath!, isAsset: false,):SizedBox(),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        closeVideos=true;
                      });
                      // Navigate to VideoCheckPage when the button is pressed
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoCheckPage(videoPath: _videoPath!, skinBrightness: Provider.of<SharedState>(context, listen: false).skinBrightness,),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor : Colors.teal, // Button color
                      foregroundColor : Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      'Upload for Checking',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
