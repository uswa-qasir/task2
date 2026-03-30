// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../services/auth_service.dart';
// import '../../services/firestore_service.dart';
// import '../../services/notification_service.dart';
// import 'manage_users.dart';
// import 'manage_categories.dart';
// import 'manage_blogs.dart';

// class AdminDashboard extends StatefulWidget {
//   @override
//   _AdminDashboardState createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   int _selectedIndex = 0;
//   final FirestoreService _firestoreService = FirestoreService();

//   final List<Widget> _screens = [
//     ManageUsers(),
//     ManageCategories(),
//     ManageBlogs(),
//   ];

//   final List<String> _titles = [
//     'Manage Users',
//     'Manage Categories',
//     'Manage Blogs',
//   ];

//   Future<void> _createSampleData() async {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Create Sample Data'),
//         content: Text(
//           'This will create sample categories and blogs. Continue?',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await _addSampleCategories();
//               await _addSampleBlogs();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Sample data created successfully!'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             child: Text('Create', style: TextStyle(color: Colors.green)),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _addSampleCategories() async {
//     List<Map<String, String>> sampleCategories = [
//       {'name': 'Technology', 'description': 'Latest tech news and updates'},
//       {
//         'name': 'Lifestyle',
//         'description': 'Health, fitness, and wellness tips',
//       },
//       {'name': 'Travel', 'description': 'Travel guides and experiences'},
//       {'name': 'Food', 'description': 'Delicious recipes and food reviews'},
//     ];

//     for (var category in sampleCategories) {
//       await _firestoreService.addCategory(
//         category['name']!,
//         category['description']!,
//       );
//     }
//   }

//   Future<void> _addSampleBlogs() async {
//     // First, get categories
//     final categoriesStream = _firestoreService.getCategories();
//     List<String> categoryIds = [];

//     await for (var categories in categoriesStream) {
//       if (categories.isNotEmpty) {
//         categoryIds = categories.map((c) => c.id).toList();
//         break;
//       }
//     }

//     if (categoryIds.isEmpty) return;

//     List<Map<String, dynamic>> sampleBlogs = [
//       {
//         'title': 'Getting Started with Flutter',
//         'content':
//             'Flutter is Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. In this tutorial, we\'ll explore the basics of Flutter development...',
//         'tags': ['Flutter', 'Dart', 'Mobile Development'],
//         'categoryId': categoryIds[0],
//         'authorName': 'Admin',
//         'imageUrl': '',
//       },
//       {
//         'title': '10 Tips for Healthy Living',
//         'content':
//             'Maintaining a healthy lifestyle doesn\'t have to be complicated. Here are 10 simple tips to improve your overall health and wellbeing...',
//         'tags': ['Health', 'Wellness', 'Lifestyle'],
//         'categoryId': categoryIds[1],
//         'authorName': 'Admin',
//         'imageUrl': '',
//       },
//       {
//         'title': 'Top 5 Travel Destinations 2024',
//         'content':
//             'Looking for your next adventure? Check out these amazing travel destinations that should be on your bucket list...',
//         'tags': ['Travel', 'Adventure', 'Destinations'],
//         'categoryId': categoryIds[2],
//         'authorName': 'Admin',
//         'imageUrl': '',
//       },
//     ];

//     for (var blog in sampleBlogs) {
//       await _firestoreService.addBlog(blog);
//       // ✅ FIXED: Using named parameters with both title and body
//       await NotificationService.sendNotification(
//         title: 'New Blog Added',
//         body: blog['title'],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_titles[_selectedIndex]),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add_circle_outline),
//             onPressed: _createSampleData,
//             tooltip: 'Create Sample Data',
//           ),
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await Provider.of<AuthService>(context, listen: false).signOut();
//             },
//           ),
//         ],
//       ),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Users'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Blogs'),
//         ],
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import 'manage_users.dart';
import 'manage_categories.dart';
import 'manage_blogs.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ManageUsers(),
    ManageCategories(),
    ManageBlogs(),
  ];

  final List<String> _titles = [
    'Manage Users',
    'Manage Categories',
    'Manage Blogs',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users', // Changed from 'title' to 'label'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories', // Changed from 'title' to 'label'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blogs', // Changed from 'title' to 'label'
          ),
        ],
      ),
    );
  }
}
