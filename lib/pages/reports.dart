import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:convert' as convert;

class Reports extends StatefulWidget {
  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  bool isLoading = true;
  Map<String, dynamic> reports = {};

  void getReports() async {
    try {
      Response response = await get(Uri.parse('https://jvp.cepheus0.com:2531/fetchData/ezra'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = convert.jsonDecode(response.body);
        print(data);
        setState(() {
          reports = data;
          isLoading = false;
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        setState(() {
          reports = {"error": 'Request failed with status: ${response.statusCode}.'};
          isLoading = false;
        });
      }
    }
    catch(e){
      print('Caught exception: $e');
      if (e is SocketException) {
        setState(() {reports = {"error": "No network! Try again!"};});
      }
      else{
        setState(() {reports = {"error": e.toString()};});
      }

      setState(() {isLoading = false;});
    }
  }

  @override
  void initState() {
    super.initState();
    getReports();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Reports'),
      ),
      body: isLoading
        ? Center(child: CircularProgressIndicator()) // Show loading indicator while video is loading
        :
        reports['error'] == null ?

        ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          var reportEntry = reports.entries.elementAt(index);
          var report = reportEntry.value;
          var title = reportEntry.key;
          IconData iconData;
          Color iconColor;

          switch (report['status']) {
            case 'success':
              iconData = Icons.check_circle_outline;
              iconColor = Colors.green;
              break;
            case 'failure':
              iconData = Icons.error_outline;
              iconColor = Colors.red;
              break;
            case 'process':
              iconData = Icons.hourglass_empty;
              iconColor = Colors.amber;
              break;
            default:
              iconData = Icons.help_outline;
              iconColor = Colors.grey;
          }

          return Card(
            child: ListTile(
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
                  SizedBox(width: 10,),
                  Text(
                    report['result'],
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ),
          );
        },
      ) :
      Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 100, color: Colors.red),
              SizedBox(height: 30,),
              Text(
                'Error while fetching data: '+reports['error'],
                style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    getReports();
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Button color
                  onPrimary: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Try Again',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
      )),
    );
  }
}
