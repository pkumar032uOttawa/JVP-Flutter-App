import 'package:flutter/material.dart';
import 'package:jvp_app/model/shared_states.dart';
import 'package:jvp_app/pages/home.dart';
import 'package:jvp_app/pages/loading.dart';
import 'package:jvp_app/pages/register.dart';
import 'package:jvp_app/pages/reports.dart';
import 'package:jvp_app/pages/login.dart';
import 'package:jvp_app/pages/video_taking.dart';
import 'package:jvp_app/ui/camera.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => SharedState(),
    child: MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoadingPage(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/home': (context) => Home(),
        '/reports': (context) => Reports(),
        '/video_taking': (context) => VideoGuidePage(),
        '/camera': (context) => CameraApp(),
      },
    ),
  )
  );
}