import 'package:rxdart/rxdart.dart';
import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late InitializationSettings initSettings;

  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotificationManager.init(){
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> initializePlatform() async {
    //TODO: Change icon to QAPTA icon
    var initSettingsAndroid = const AndroidInitializationSettings('app_notification_icon');
    var initSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification = ReceiveNotification(
            id: id,
            title: title!,
            body: body!,
            payload: payload!,
          );
          didReceiveLocalNotificationSubject.add(notification);
        });
    initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  setOnNotificationClick(Function onNotificationClicked) async {
    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String? payload) async {
      onNotificationClicked(payload);
    });
  }

  Future<void> showNotification() async {
    var androidChannel = const AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      priority: Priority.high,
      playSound: true,
      importance: Importance.max,
    );
    var iosChannel = const IOSNotificationDetails();
    var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
    await flutterLocalNotificationsPlugin.show(
      0,
      "Завершите поездку",
      "Необходимо завершить поездку для записи данных в нашу базу.",
      platformChannel,
      payload: "New payload",
    );
  }
}

LocalNotificationManager localNotificationManager = LocalNotificationManager.init();

class ReceiveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceiveNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
