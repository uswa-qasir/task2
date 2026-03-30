// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task2/screens/admin/admin_dashboard.dart';
// import 'package:task2/screens/auth/login_screen.dart';
// import 'package:task2/screens/users/user_dashboard.dart';
// import 'package:task2/services/auth_service.dart';
// import 'package:task2/services/notification_service.dart';
// import 'package:task2/utils/constants.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     // Initialize Firebase
//     await Firebase.initializeApp();
//     print('✅ Firebase initialized successfully');

//     // Initialize Notifications
//     await NotificationService.initialize();
//     print('✅ Notification service initialized');

//     // Request notification permissions
//     await _requestNotificationPermissions();
//   } catch (e) {
//     print('❌ Error during initialization: $e');
//     // Handle initialization error
//   }

//   runApp(MyApp());
// }

// // Request notification permissions
// Future<void> _requestNotificationPermissions() async {
//   try {
//     NotificationSettings settings = await FirebaseMessaging.instance
//         .requestPermission(
//           alert: true,
//           badge: true,
//           sound: true,
//           provisional: false,
//         );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('✅ Notification permissions granted');

//       // Get and log FCM token
//       String? token = await FirebaseMessaging.instance.getToken();
//       print('📱 FCM Token: $token');
//     } else {
//       print('❌ Notification permissions denied');
//     }
//   } catch (e) {
//     print('Error requesting permissions: $e');
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [ChangeNotifierProvider(create: (_) => AuthService())],
//       child: MaterialApp(
//         title: AppConstants.appName,
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           fontFamily: 'Poppins',
//           scaffoldBackgroundColor: Colors.white,
//           appBarTheme: AppBarTheme(
//             elevation: 0,
//             backgroundColor: Colors.white,
//             foregroundColor: Colors.black,
//             titleTextStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               elevation: 2,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//           inputDecorationTheme: InputDecorationTheme(
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(color: Colors.blue, width: 2),
//             ),
//           ),
//         ),
//         home: StreamBuilder<User?>(
//           stream: AuthService().authStateChanges,
//           builder: (context, snapshot) {
//             // Handle connection state
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return _buildLoadingScreen('Checking authentication...');
//             }

//             // Handle error
//             if (snapshot.hasError) {
//               print('❌ Auth state error: ${snapshot.error}');
//               return _buildErrorScreen(
//                 'Authentication Error',
//                 snapshot.error.toString(),
//               );
//             }

//             // Handle user state
//             final user = snapshot.data;

//             if (user == null) {
//               // User is not logged in
//               return LoginScreen();
//             }

//             // User is logged in, get their role
//             return FutureBuilder<String?>(
//               future: AuthService().getUserRole(user.uid),
//               builder: (context, roleSnapshot) {
//                 // Loading role
//                 if (roleSnapshot.connectionState == ConnectionState.waiting) {
//                   return _buildLoadingScreen('Loading user profile...');
//                 }

//                 // Error getting role
//                 if (roleSnapshot.hasError) {
//                   print('❌ Role fetch error: ${roleSnapshot.error}');
//                   return _buildErrorScreen(
//                     'Error',
//                     'Failed to load user role. Please try again.',
//                   );
//                 }

//                 final role = roleSnapshot.data;
//                 print('✅ User role: $role');

//                 // Check if user is active
//                 return FutureBuilder<bool>(
//                   future: AuthService().isUserActive(user.uid),
//                   builder: (context, activeSnapshot) {
//                     if (activeSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return _buildLoadingScreen('Checking account status...');
//                     }

//                     final isActive = activeSnapshot.data ?? true;

//                     if (!isActive) {
//                       return _buildSuspendedScreen();
//                     }

//                     // Navigate based on role
//                     if (role == 'admin') {
//                       return AdminDashboard();
//                     } else {
//                       return UserDashboard();
//                     }
//                   },
//                 );
//               },
//             );
//           },
//         ),
//         // Add error handling for routing
//         onGenerateRoute: (settings) {
//           print('🔄 Navigating to: ${settings.name}');
//           return null;
//         },
//         // ✅ FIXED: Removed onError parameter - it doesn't exist in MaterialApp
//         // Use ErrorWidget.builder for error handling instead
//       ),
//     );
//   }

//   // Loading screen widget
//   Widget _buildLoadingScreen(String message) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(),
//             SizedBox(height: 16),
//             Text(
//               message,
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Error screen widget
//   Widget _buildErrorScreen(String title, String message) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error_outline, size: 80, color: Colors.red),
//               SizedBox(height: 16),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 message,
//                 style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   // Try to sign out and go to login
//                   AuthService().signOut();
//                 },
//                 child: Text('Go to Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Suspended account screen
//   Widget _buildSuspendedScreen() {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.block, size: 80, color: Colors.orange),
//               SizedBox(height: 16),
//               Text(
//                 'Account Suspended',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.orange,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Your account has been suspended. Please contact the administrator for assistance.',
//                 style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () async {
//                   await AuthService().signOut();
//                 },
//                 child: Text('Logout'),
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/screens/admin/admin_dashboard.dart';
import 'package:task2/screens/auth/login_screen.dart';

import 'package:task2/screens/users/user_dashboard.dart';
import 'package:task2/services/auth_service.dart';
import 'package:task2/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthService())],
      child: MaterialApp(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StreamBuilder<User?>(
          stream: AuthService().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                return LoginScreen();
              }
              return FutureBuilder<String?>(
                future: AuthService().getUserRole(user.uid),
                builder: (context, roleSnapshot) {
                  if (roleSnapshot.connectionState == ConnectionState.done) {
                    final role = roleSnapshot.data;
                    if (role == 'admin') {
                      return AdminDashboard();
                    } else {
                      return UserDashboard();
                    }
                  }
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                },
              );
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
