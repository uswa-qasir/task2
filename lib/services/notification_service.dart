// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';

// // class NotificationService {
// //   static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

// //   static Future<void> initialize() async {
// //     try {
// //       // Request permissions
// //       NotificationSettings settings = await _fcm.requestPermission(
// //         alert: true,
// //         badge: true,
// //         sound: true,
// //       );

// //       print('Notification permission granted: ${settings.authorizationStatus}');

// //       // Get FCM token
// //       String? token = await _fcm.getToken();
// //       print('FCM Token: $token');

// //       // Handle foreground messages (when app is open)
// //       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //         _showInAppNotification(message);
// //       });

// //       // Handle background messages (when app is in background)
// //       FirebaseMessaging.onBackgroundMessage(
// //         _firebaseMessagingBackgroundHandler,
// //       );

// //       // Handle when app is opened from terminated state
// //       FirebaseMessaging.instance.getInitialMessage().then((
// //         RemoteMessage? message,
// //       ) {
// //         if (message != null) {
// //           _handleMessage(message);
// //         }
// //       });

// //       // Handle when app is opened from background
// //       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// //         _handleMessage(message);
// //       });
// //     } catch (e) {
// //       print('Error initializing notifications: $e');
// //     }
// //   }

// //   // Background message handler
// //   @pragma('vm:entry-point')
// //   static Future<void> _firebaseMessagingBackgroundHandler(
// //     RemoteMessage message,
// //   ) async {
// //     print("Handling background message: ${message.messageId}");
// //     print("Notification Title: ${message.notification?.title}");
// //     print("Notification Body: ${message.notification?.body}");
// //   }

// //   // Show in-app notification using Flutter Toast
// //   static void _showInAppNotification(RemoteMessage message) {
// //     String title = message.notification?.title ?? 'Notification';
// //     String body = message.notification?.body ?? '';

// //     Fluttertoast.showToast(
// //       msg: '$title\n$body',
// //       toastLength: Toast.LENGTH_LONG,
// //       gravity: ToastGravity.TOP,
// //       backgroundColor: Colors.black87,
// //       textColor: Colors.white,
// //       fontSize: 14.0,
// //     );

// //     print('In-app notification received: $title - $body');
// //   }

// //   // Handle message when user taps on notification
// //   static void _handleMessage(RemoteMessage message) {
// //     print('User tapped on notification: ${message.messageId}');
// //   }

// //   // ========== METHOD 1: Named Parameters (For your current code) ==========
// //   static Future<void> sendNotification({
// //     required String title,
// //     required String body,
// //     Map<String, String>? data,
// //   }) async {
// //     try {
// //       // Get FCM token
// //       String? token = await _fcm.getToken();

// //       if (token != null) {
// //         print('Sending notification: $title');
// //         print('Body: $body');
// //         print('Data: $data');

// //         // Show toast for visual feedback
// //         Fluttertoast.showToast(
// //           msg: '📢 $title\n$body',
// //           toastLength: Toast.LENGTH_LONG,
// //           gravity: ToastGravity.BOTTOM,
// //           backgroundColor: Colors.blue,
// //           textColor: Colors.white,
// //           fontSize: 14.0,
// //         );
// //       } else {
// //         print('No FCM token available');
// //         Fluttertoast.showToast(
// //           msg: 'Notification: $title',
// //           toastLength: Toast.LENGTH_SHORT,
// //           gravity: ToastGravity.BOTTOM,
// //         );
// //       }
// //     } catch (e) {
// //       print('Error sending notification: $e');
// //       Fluttertoast.showToast(
// //         msg: 'Error sending notification',
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //       );
// //     }
// //   }

// //   // ========== METHOD 2: Positional Parameters (Alternative) ==========
// //   static Future<void> sendNotificationSimple(String title, String body) async {
// //     await sendNotification(title: title, body: body);
// //   }

// //   // Send notification to specific topic
// //   static Future<void> sendNotificationToTopic({
// //     required String topic,
// //     required String title,
// //     required String body,
// //   }) async {
// //     try {
// //       print('Sending notification to topic: $topic');
// //       print('Title: $title');
// //       print('Body: $body');

// //       // Subscribe to topic (for testing)
// //       await subscribeToTopic(topic);

// //       // Show toast for demo
// //       Fluttertoast.showToast(
// //         msg: 'Notification sent to $topic topic',
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.BOTTOM,
// //       );
// //     } catch (e) {
// //       print('Error sending topic notification: $e');
// //     }
// //   }

// //   // Subscribe to topic
// //   static Future<void> subscribeToTopic(String topic) async {
// //     try {
// //       await _fcm.subscribeToTopic(topic);
// //       print('Subscribed to topic: $topic');
// //     } catch (e) {
// //       print('Error subscribing to topic: $e');
// //     }
// //   }

// //   // Unsubscribe from topic
// //   static Future<void> unsubscribeFromTopic(String topic) async {
// //     try {
// //       await _fcm.unsubscribeFromTopic(topic);
// //       print('Unsubscribed from topic: $topic');
// //     } catch (e) {
// //       print('Error unsubscribing from topic: $e');
// //     }
// //   }

// //   // Get FCM token
// //   static Future<String?> getToken() async {
// //     try {
// //       String? token = await _fcm.getToken();
// //       return token;
// //     } catch (e) {
// //       print('Error getting token: $e');
// //       return null;
// //     }
// //   }

// //   // Delete token (for logout)
// //   static Future<void> deleteToken() async {
// //     try {
// //       await _fcm.deleteToken();
// //       print('FCM token deleted');
// //     } catch (e) {
// //       print('Error deleting token: $e');
// //     }
// //   }
// // }
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class NotificationService {
//   static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   static Future<void> initialize() async {
//     try {
//       // Request permissions
//       NotificationSettings settings = await _fcm.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//       );

//       print('Notification permission granted: ${settings.authorizationStatus}');

//       // Get FCM token
//       String? token = await _fcm.getToken();
//       print('FCM Token: $token');

//       // Handle foreground messages (when app is open)
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         _showInAppNotification(message);
//       });

//       // Handle background messages (when app is in background)
//       FirebaseMessaging.onBackgroundMessage(
//         _firebaseMessagingBackgroundHandler,
//       );

//       // Handle when app is opened from terminated state
//       FirebaseMessaging.instance.getInitialMessage().then((
//         RemoteMessage? message,
//       ) {
//         if (message != null) {
//           _handleMessage(message);
//         }
//       });

//       // Handle when app is opened from background
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         _handleMessage(message);
//       });
//     } catch (e) {
//       print('Error initializing notifications: $e');
//     }
//   }

//   // Background message handler
//   @pragma('vm:entry-point')
//   static Future<void> _firebaseMessagingBackgroundHandler(
//     RemoteMessage message,
//   ) async {
//     print("Handling background message: ${message.messageId}");
//     print("Notification Title: ${message.notification?.title}");
//     print("Notification Body: ${message.notification?.body}");
//   }

//   // Show in-app notification using Flutter Toast
//   static void _showInAppNotification(RemoteMessage message) {
//     String title = message.notification?.title ?? 'Notification';
//     String body = message.notification?.body ?? 'You have a new notification';

//     Fluttertoast.showToast(
//       msg: '$title\n$body',
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       backgroundColor: Colors.black87,
//       textColor: Colors.white,
//       fontSize: 14.0,
//     );

//     print('In-app notification received: $title - $body');
//   }

//   // Handle message when user taps on notification
//   static void _handleMessage(RemoteMessage message) {
//     print('User tapped on notification: ${message.messageId}');
//     Fluttertoast.showToast(
//       msg:
//           'Notification tapped: ${message.notification?.title ?? 'Notification'}',
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//     );
//   }

//   // Send notification with named parameters (CORRECT METHOD)
//   static Future<void> sendNotification({
//     required String title,
//     required String body,
//     Map<String, String>? data,
//   }) async {
//     try {
//       // Get FCM token
//       String? token = await _fcm.getToken();

//       if (token != null) {
//         print('Sending notification: $title');
//         print('Body: $body');
//         print('Data: $data');
//         print('FCM Token: $token');

//         // Show toast for visual feedback
//         Fluttertoast.showToast(
//           msg: '📢 $title\n$body',
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.blue,
//           textColor: Colors.white,
//           fontSize: 14.0,
//         );
//       } else {
//         print('No FCM token available');
//         Fluttertoast.showToast(
//           msg: 'Notification: $title',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.orange,
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       print('Error sending notification: $e');
//       Fluttertoast.showToast(
//         msg: 'Error sending notification',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }

//   // Simple method to send notification (calls the named parameter method)
//   static Future<void> sendNotificationSimple(String title, String body) async {
//     await sendNotification(title: title, body: body);
//   }

//   // Send notification to specific topic
//   static Future<void> sendNotificationToTopic({
//     required String topic,
//     required String title,
//     required String body,
//   }) async {
//     try {
//       print('Sending notification to topic: $topic');
//       print('Title: $title');
//       print('Body: $body');

//       // Subscribe to topic (for testing)
//       await subscribeToTopic(topic);

//       // Show toast for demo
//       Fluttertoast.showToast(
//         msg: 'Notification sent to $topic topic',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//     } catch (e) {
//       print('Error sending topic notification: $e');
//       Fluttertoast.showToast(
//         msg: 'Error sending topic notification',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }

//   // Subscribe to topic
//   static Future<void> subscribeToTopic(String topic) async {
//     try {
//       await _fcm.subscribeToTopic(topic);
//       print('Subscribed to topic: $topic');
//     } catch (e) {
//       print('Error subscribing to topic: $e');
//     }
//   }

//   // Unsubscribe from topic
//   static Future<void> unsubscribeFromTopic(String topic) async {
//     try {
//       await _fcm.unsubscribeFromTopic(topic);
//       print('Unsubscribed from topic: $topic');
//     } catch (e) {
//       print('Error unsubscribing from topic: $e');
//     }
//   }

//   // Get FCM token
//   static Future<String?> getToken() async {
//     try {
//       String? token = await _fcm.getToken();
//       return token;
//     } catch (e) {
//       print('Error getting token: $e');
//       return null;
//     }
//   }

//   // Delete token (for logout)
//   static Future<void> deleteToken() async {
//     try {
//       await _fcm.deleteToken();
//       print('FCM token deleted');
//     } catch (e) {
//       print('Error deleting token: $e');
//     }
//   }
// }
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    try {
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      print('Notification permission: ${settings.authorizationStatus}');

      String? token = await _fcm.getToken();
      print('FCM Token: $token');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showInAppNotification(message);
      });

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    print("Handling background message: ${message.messageId}");
  }

  static void _showInAppNotification(RemoteMessage message) {
    String title = message.notification?.title ?? 'Notification';
    String body = message.notification?.body ?? 'New update';

    Fluttertoast.showToast(
      msg: '$title\n$body',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }

  static Future<void> sendNotification({
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    try {
      print('Sending notification: $title');
      print('Body: $body');

      Fluttertoast.showToast(
        msg: '📢 $title\n$body',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}
