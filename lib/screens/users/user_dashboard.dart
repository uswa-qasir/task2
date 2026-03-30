// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task2/screens/users/%20blog_list.dart';
// import '../../services/auth_service.dart';

// class UserDashboard extends StatefulWidget {
//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }

// class _UserDashboardState extends State<UserDashboard> {
//   int _selectedIndex = 0;

//   final List<Widget> _screens = [
//     BlogList(),
//     // Add more screens here if needed
//   ];

//   final List<String> _titles = ['Blogs'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_titles[_selectedIndex]),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await Provider.of<AuthService>(context, listen: false).signOut();
//             },
//           ),
//         ],
//       ),
//       body: _screens[_selectedIndex],
//       // FIXED: BottomNavigationBar removed since only one screen
//       // If you want to keep BottomNavigationBar, you need at least 2 items
//       // For now, we'll remove it since there's only one screen
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/screens/users/%20blog_list.dart';
import '../../services/auth_service.dart';

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blogs'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: BlogList(),
    );
  }
}
