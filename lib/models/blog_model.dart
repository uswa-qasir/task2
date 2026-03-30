// import 'package:cloud_firestore/cloud_firestore.dart';

// class BlogModel {
//   final String id;
//   final String title;
//   final String content;
//   final List<String> tags;
//   final String imageUrl;
//   final String categoryId;
//   final String authorId;
//   final String authorName;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int views;

//   BlogModel({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.tags,
//     required this.imageUrl,
//     required this.categoryId,
//     required this.authorId,
//     required this.authorName,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.views,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'content': content,
//       'tags': tags,
//       'imageUrl': imageUrl,
//       'categoryId': categoryId,
//       'authorId': authorId,
//       'authorName': authorName,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'views': views,
//     };
//   }

//   factory BlogModel.fromMap(Map<String, dynamic> map, String id) {
//     return BlogModel(
//       id: id,
//       title: map['title'] ?? '',
//       content: map['content'] ?? '',
//       tags: List<String>.from(map['tags'] ?? []),
//       imageUrl: map['imageUrl'] ?? '',
//       categoryId: map['categoryId'] ?? '',
//       authorId: map['authorId'] ?? '',
//       authorName: map['authorName'] ?? '',
//       createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       views: map['views'] ?? 0,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final String imageUrl;
  final String categoryId;
  final String authorId;
  final String authorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int views;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.imageUrl,
    required this.categoryId,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    required this.views,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'views': views,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map, String id) {
    return BlogModel(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      imageUrl: map['imageUrl'] ?? '',
      categoryId: map['categoryId'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      views: map['views'] ?? 0,
    );
  }
}
