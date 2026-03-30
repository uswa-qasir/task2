// import 'package:cloud_firestore/cloud_firestore.dart';

// class CategoryModel {
//   final String id;
//   final String name;
//   final String description;
//   final DateTime createdAt;

//   CategoryModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.createdAt,
//   });

//   Map<String, dynamic> toMap() {
//     return {'name': name, 'description': description, 'createdAt': createdAt};
//   }

//   factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
//     return CategoryModel(
//       id: id,
//       name: map['name'] ?? '',
//       description: map['description'] ?? '',
//       createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'createdAt': createdAt};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
