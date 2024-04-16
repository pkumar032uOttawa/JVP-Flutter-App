import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ReportDetail extends StatefulWidget {
  final String username;
  final String filename;
  final String status;
  final String message;
  final String HR;
  final String BR;
  final String VP;

  ReportDetail({required this.username, required this.filename, required this.status, required this.message, required this.HR, required this.BR, required this.VP});

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  bool imageFailed = false;
  late String imageUrl;
  String getTitle(status){
    if(status == "success"){
      return "Report Produced!";
    }
    else if(status == "failure"){
      return "Video Analysis Failed!";
    }
    else{
      return "In Progress";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the total height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    imageUrl = 'https://jvp.cepheus0.com:2531/getReportImage/' + widget.username+'/'+widget.filename;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top half with Gradient Background
            Container(
              height: screenHeight * 0.5, // 50% of the screen height for the gradient background
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade900, Colors.transparent],
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                getTitle(widget.status),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Bottom half with White Background and Information Tiles
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  InformationTile(
                    title: 'Message',
                    value: widget.message, // Example data, replace with actual data
                    icon: Icons.message_outlined,
                  ),
                  InformationTile(
                    title: 'Heart Rate',
                    value: '${widget.HR} bpm', // Example data, replace with actual data
                    icon: Icons.favorite,
                  ),
                  InformationTile(
                    title: 'Breathing Rate',
                    value: '${widget.BR} bpm', // Example data, replace with actual data
                    icon: Icons.air,
                  ),
                  InformationTile(
                    title: 'Jugular Vein Height',
                    value: '${widget.VP} cm', // Example data, replace with actual data
                    icon: Icons.show_chart,
                  ),
                  InformationTile(
                    title: 'Image of Detected Results',
                    value: 'Double check to see if the three positions are detected correctly', // Example data, replace with actual data
                    icon: Icons.arrow_downward_outlined,
                  ),

                  Container(
                    height: screenHeight,
                    width: screenWidth,
                    child: Center(
                        // Use Image.network to load and display the image from the server
                        child: Image.network(imageUrl,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return InformationTile(
                              title: 'Failed to load image',
                              value: exception.toString(), // Example data, replace with actual data
                              icon: Icons.error_outline,
                            );
                          },
                        ),
                      ),
                  ),
                  // Add more tiles if needed
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
