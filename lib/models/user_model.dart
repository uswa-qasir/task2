// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserModel {
//   final String uid;
//   final String email;
//   final String name;
//   final String role;
//   final bool isActive;
//   final DateTime createdAt;
//   final DateTime lastLogin;

//   UserModel({
//     required this.uid,
//     required this.email,
//     required this.name,
//     required this.role,
//     required this.isActive,
//     required this.createdAt,
//     required this.lastLogin,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'email': email,
//       'name': name,
//       'role': role,
//       'isActive': isActive,
//       'createdAt': createdAt,
//       'lastLogin': lastLogin,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
//     return UserModel(
//       uid: uid,
//       email: map['email'] ?? '',
//       name: map['name'] ?? '',
//       role: map['role'] ?? 'user',
//       isActive: map['isActive'] ?? true,
//       createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       lastLogin: (map['lastLogin'] as Timestamp?)?.toDate() ?? DateTime.now(),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime lastLogin;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'role': role,
      'isActive': isActive,
      'createdAt': createdAt,
      'lastLogin': lastLogin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      role: map['role'] ?? 'user',
      isActive: map['isActive'] ?? true,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin: (map['lastLogin'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
