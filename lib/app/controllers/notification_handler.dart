import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

class FirebaseMessagingHandler {
  FirebaseMessaging Messaging = FirebaseMessaging.instance;

  final androidchannel = const AndroidNotificationChannel(
    'channel_notification',
    'High Importance Notification',
    description: 'Used For Notification',
    importance: Importance.defaultImportance,
  );

  final localnotification = FlutterLocalNotificationsPlugin();

  Future<void> initPushNotification() async {
    // Request permission
    NotificationSettings settings = await Messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    // Get FCM Token
    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        print('FCM Token: $token');
      } else {
        print('Failed to get FCM token');
      }
    }).catchError((error) {
      print('Error fetching FCM token: $error');
    });

    // Handle initial message when app is terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Terminated Notification: ${message.notification?.title}");
      }
    });

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message while app is in foreground');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.notification}');
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'your_app_icon',
          ),
        ),
      );
    });

    // Handle foreground messages
    // FirebaseMessaging.onMessage.listen((message) {
    //   final notification = message.notification;
    //   if (notification == null) return;
    //   localnotification.show(
    //     notification.hashCode,
    //     notification.title,
    //     notification.body,
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         androidchannel.id,
    //         androidchannel.name,
    //         channelDescription: androidchannel.description,
    //         icon: '@mipmap/ic_launcher',
    //       ),
    //     ),
    //     payload: jsonEncode(message.toMap()),
    //   );
    //   print('Message received in foreground: ${message.notification?.title}');
    // });
  }

  Future<void> initlocalnotification() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android, iOS: ios);

    await localnotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          print('Notification Payload: ${response.payload}');
        }
      },
    );
  }
}
