import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';
import 'package:jvp_app/provider/admin_provider.dart';
import 'package:provider/provider.dart';
import 'package:jvp_app/provider/shared_states.dart';
import 'package:jvp_app/pages/report_detail.dart';

import '../provider/user_provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class Reports extends StatefulWidget {
  final bool? isAdmin;

  const Reports({super.key, this.isAdmin = false});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  bool isLoading = true;
  late String username;
  List<UserReport>? _reports;

  Future<List<UserReport>?> _getReports() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      List<UserReport>? _userReports;
      if (widget.isAdmin!) {
        _userReports = await Provider.of<AdminProvider>(context, listen: false)
            .readAllReports();
      } else {
        _userReports = await Provider.of<UserProvider>(context, listen: false)
            .readReportsByUserId(user.userId);
      }
      setState(() {
        _reports = _userReports;
        isLoading = false;
      });
      return _reports;
    } catch (e) {
      print('Caught exception: $e');
      setState(() {
        isLoading = false;
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    username = Provider.of<SharedState>(context, listen: false).username;
    _getReports();
  }


  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);
    final userReports = adminProvider.userReports;
    if(widget.isAdmin ?? false) _reports = userReports;
    return Scaffold(
        appBar: AppBar(
          title: Text(
              widget.isAdmin! ? 'Manage Reports Submitted' : 'View Reports'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _getReports,
                child: _reports != null && _reports!.isNotEmpty
                    ? ListView.builder(
                        itemCount: _reports!.length,
                        itemBuilder: (context, index) {
                          IconData iconData;
                          Color iconColor;
                          final report = _reports![index];
                          switch (report.feedbackStatus) {
                            case FeedbackStatus.GIVEN:
                              iconData = Icons.check_circle_outline;
                              iconColor = Colors.green;
                              break;
                            case FeedbackStatus.PENDING:
                              iconData = Icons.hourglass_empty;
                              iconColor = Colors.amber;
                              break;
                            default:
                              iconData = Icons.help_outline;
                              iconColor = Colors.grey;
                          }

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportDetail(
                                    userReport: report,
                                    title: "Report ${index + 1}",
                                    isAdmin: widget.isAdmin ?? false,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: Icon(iconData, color: iconColor),
                                      title: Text(
                                        "Report ${index + 1}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            '${report.commentsByDoctor == null ? "Feedback Pending" : "Feedback Given"}'
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                              color: iconColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      )),
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
                            'No Reports Found',
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
                                _getReports();
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
