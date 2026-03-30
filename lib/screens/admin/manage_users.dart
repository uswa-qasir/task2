// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../services/firestore_service.dart';
// import '../../services/notification_service.dart';
// import '../../models/user_model.dart';

// class ManageUsers extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final firestoreService = FirestoreService();

//     return StreamBuilder<List<UserModel>>(
//       stream: firestoreService.getAllUsers(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }

//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         final users = snapshot.data!;

//         if (users.isEmpty) {
//           return Center(child: Text('No users found'));
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(16),
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final user = users[index];
//             return Card(
//               margin: EdgeInsets.only(bottom: 12),
//               child: ListTile(
//                 leading: CircleAvatar(child: Text(user.name[0].toUpperCase())),
//                 title: Text(user.name),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(user.email),
//                     Text('Role: ${user.role}', style: TextStyle(fontSize: 12)),
//                   ],
//                 ),
//                 trailing: Switch(
//                   value: user.isActive,
//                   onChanged: (bool value) async {
//                     await firestoreService.updateUserStatus(user.uid, value);

//                     // FIXED: Send notification with named parameters
//                     await NotificationService.sendNotification(
//                       title: 'User Status Changed',
//                       body:
//                           '${user.name} is now ${value ? "active" : "suspended"}',
//                     );

//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'User ${value ? "activated" : "suspended"} successfully',
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/user_model.dart';

class ManageUsers extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: _firestoreService.getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final users = snapshot.data!;
        if (users.isEmpty) {
          return Center(child: Text('No users found'));
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(child: Text(user.name[0].toUpperCase())),
                title: Text(user.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.email),
                    Text('Role: ${user.role}', style: TextStyle(fontSize: 12)),
                  ],
                ),
                trailing: Switch(
                  value: user.isActive,
                  onChanged: (bool value) async {
                    await _firestoreService.updateUserStatus(user.uid, value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'User ${value ? "activated" : "suspended"}',
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
