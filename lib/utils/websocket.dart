import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WebSocketConnection{
  WebSocketChannel? channel;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  WebSocketConnection(id){
    // Initialize the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(InitializationSettings(
    //   android: AndroidInitializationSettings('icon'),
    // ));

    channel = WebSocketChannel.connect(
      Uri.parse('wss://jvp.cepheus0.com:2531/?id=$id'),
    );
    // Listen to messages
    channel!.stream.listen((message) {
      print("Received: $message");
      // Optionally, show a notification or handle the message further
      _showNotification(message);
    });
  }


  Future<void> _showNotification(message) async {
    // const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   'JVP_APP_CHANNEL_ID', 'JVP_APP_CHANNEL_NAME',
    //   channelDescription: 'This is used for JVP app notifications',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   ticker: 'ticker',
    //   color: Colors.blue,
    // );
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.show(
    //     0, 'JVP Notification', message,
    //     platformChannelSpecifics,
    //     payload: 'item x');
  }

}
