import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:jvp_app/utils/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:jvp_app/provider/shared_states.dart';
import 'package:jvp_app/pages/report_detail.dart';

class Reports extends StatefulWidget {
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  bool isLoading = true;
  late String username;
  Map<String, dynamic> reports = {};

  Future<void> getReports() async {
    try {

    } catch (e) {
      print('Caught exception: $e');
      if (e is SocketException) {
        setState(() {
          reports = {"error": "No network! Try again!"};
        });
      } else {
        setState(() {
          reports = {"error": e.toString()};
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    username = Provider.of<SharedState>(context, listen: false).username;
    getReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Reports'),
        ),
        body: isLoading
            ? Center(
                child:
                    CircularProgressIndicator()
              ) // Show loading indicator while video is loading
            : RefreshIndicator(
                onRefresh: getReports,
                child: reports['error'] == null
                    ? ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          var reportEntry = reports.entries.elementAt(index);
                          var report = reportEntry.value;
                          var title = reportEntry.key;
                          IconData iconData;
                          Color iconColor;
                          bool showProgress;

                          switch (report['status']) {
                            case 'success':
                              iconData = Icons.check_circle_outline;
                              iconColor = Colors.green;
                              showProgress = false;
                              break;
                            case 'failure':
                              iconData = Icons.error_outline;
                              iconColor = Colors.red;
                              showProgress = false;
                              break;
                            case 'process':
                              iconData = Icons.hourglass_empty;
                              iconColor = Colors.amber;
                              showProgress = true;
                              break;
                            default:
                              iconData = Icons.help_outline;
                              iconColor = Colors.grey;
                              showProgress = false;
                          }

                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportDetail(
                                      username: username,
                                      filename: title,
                                      status: report['status'],
                                      message: report["details"]["message"],
                                      HR: report["details"]["HR"].toString(),
                                      BR: report["details"]["BR"].toString(),
                                      VP: report["details"]["VP"].toString()),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: Icon(iconData, color: iconColor),
                                      title: Text(
                                        title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            '${report['status']}'.toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: iconColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            report['result'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )),
                                  showProgress
                                      ? Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 5.0, 20.0, 10.0),
                                          child: CheckpointProgressBar(
                                              currentIndex: report['progress']),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error, size: 100, color: Colors.red),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Error while fetching data: ' + reports['error'],
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                                getReports();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal, // Button color
                              foregroundColor: Colors.white, // Text color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            child: Text(
                              'Try Again',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        ],
                      ))));
  }
}
