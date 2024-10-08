import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';
import 'package:jvp_app/ui/video_player.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class ReportDetail extends StatefulWidget {
  final String title;
  final UserReport userReport;

  ReportDetail({
    required this.title,
    required this.userReport,
  });

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  bool imageFailed = false;
  late String videoUrl;

  String getTitle(status) {
    if (status == "success") {
      return "Report Produced!";
    } else if (status == "failure") {
      return "Video Analysis Failed!";
    } else {
      return "In Progress";
    }
  }

  Map<String, bool?> answers = {
    'Do you have heart disease?': null,
    'Have you ever had a stroke?': null,
    'Do you experience chest pains frequently?': null,
    'Do you suffer from high blood pressure?': null,
    'Is there a family history of heart disease?': null,
    'Do you smoke?': null,
  };

  @override
  void initState() {
    super.initState();
    final report = widget.userReport;
    answers['Do you have heart disease?'] = report.heartDisease;
    answers["Have you ever had a stroke?"] = report.everHadAStroke;
    answers["Do you experience chest pains frequently?"] =
        report.experienceChestPainsFrequently;
    answers["Do you suffer from high blood pressure?"] =
        report.sufferHighBloodPressure;
    answers["Is there a family history of heart disease?"] =
        report.familyHistoryHeartDisease;
    answers["Do you smoke?"] = report.smoke;
    _getVideoUrl();
  }

  _getVideoUrl() async {
    videoUrl = await Provider.of<UserProvider>(context, listen: false)
        .getUrl(widget.userReport.videoUrl);
    print(videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final report = widget.userReport;
    final commentsByDoctor = widget.userReport.commentsByDoctor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + " Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Top half with Gradient Background
            Container(
              height: screenHeight * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade900, Colors.transparent],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                getTitle(widget.userReport.feedbackStatus),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Bottom half with White Background and Information Tiles
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Details Submitted",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: screenWidth,
              child: VideoPlayerUrl(
                videoUrl: widget.userReport.videoUrl,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ...answers.keys.map((String question) {
              bool isDisabled = answers[question] != null;
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        question,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio<bool>(
                          value: true,
                          groupValue: answers[question],
                          onChanged: isDisabled
                              ? null
                              : (bool? value) {
                                  setState(() {
                                    answers[question] = value;
                                  });
                                },
                        ),
                        Text('Yes'),
                        Radio<bool>(
                          value: false,
                          groupValue: answers[question],
                          onChanged: isDisabled
                              ? null
                              : (bool? value) {
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

            Container(
              color: Colors.white,
              child: Column(
                children: [
                  commentsByDoctor != null
                      ? InformationTile(
                          title: 'Message',
                          value: commentsByDoctor,
                          icon: Icons.message_outlined,
                        )
                      : SizedBox(),
                  report.heartRate != null
                      ? InformationTile(
                          title: 'Heart Rate',
                          value: '${report.heartRate} bpm',
                          icon: Icons.favorite,
                        )
                      : SizedBox(),
                  report.breathingRate != null
                      ? InformationTile(
                          title: 'Breathing Rate',
                          value: '${report.breathingRate} bpm',
                          icon: Icons.air,
                        )
                      : SizedBox(),
                  report.JugularVeinHeight != null
                      ? InformationTile(
                          title: 'Jugular Vein Height',
                          value: '${report.JugularVeinHeight} cm',
                          icon: Icons.show_chart,
                        )
                      : SizedBox(),
                  report.ImageOfDetectedResultUrl != null
                      ? Column(
                          children: [
                            InformationTile(
                              title: 'Image of Detected Results',
                              value:
                                  'Double check to see if the three positions are detected correctly',
                              icon: Icons.arrow_downward_outlined,
                            ),
                            Container(
                              height: screenHeight,
                              width: screenWidth,
                              child: Center(
                                child: Image.network(
                                  report.ImageOfDetectedResultUrl!,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return InformationTile(
                                      title: 'Failed to load image',
                                      value: exception.toString(),
                                      icon: Icons.error_outline,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InformationTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InformationTile({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[800]),
      title: Text(title),
      subtitle: Text(
        value,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
