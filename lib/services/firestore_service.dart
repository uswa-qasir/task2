// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/category_model.dart';
// import '../models/blog_model.dart';
// import '../models/user_model.dart';

// class FirestoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // User Management
//   Stream<List<UserModel>> getAllUsers() {
//     return _firestore.collection('users').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return UserModel.fromMap(doc.data(), doc.id);
//       }).toList();
//     });
//   }

//   Future<void> updateUserStatus(String userId, bool isActive) async {
//     await _firestore.collection('users').doc(userId).update({
//       'isActive': isActive,
//     });
//   }

//   // Category CRUD
//   Future<void> addCategory(String name, String description) async {
//     await _firestore.collection('categories').add({
//       'name': name,
//       'description': description,
//       'createdAt': DateTime.now(),
//     });
//   }

//   Future<void> updateCategory(
//     String id,
//     String name,
//     String description,
//   ) async {
//     await _firestore.collection('categories').doc(id).update({
//       'name': name,
//       'description': description,
//       'updatedAt': DateTime.now(),
//     });
//   }

//   Future<void> deleteCategory(String id) async {
//     await _firestore.collection('categories').doc(id).delete();
//   }

//   Stream<List<CategoryModel>> getCategories() {
//     return _firestore
//         .collection('categories')
//         .orderBy('createdAt')
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs.map((doc) {
//             return CategoryModel.fromMap(doc.data(), doc.id);
//           }).toList();
//         });
//   }

//   // Blog CRUD
//   Future<void> addBlog(Map<String, dynamic> blogData) async {
//     await _firestore.collection('blogs').add({
//       ...blogData,
//       'createdAt': DateTime.now(),
//       'updatedAt': DateTime.now(),
//       'views': 0,
//     });
//   }

//   Future<void> updateBlog(String id, Map<String, dynamic> blogData) async {
//     await _firestore.collection('blogs').doc(id).update({
//       ...blogData,
//       'updatedAt': DateTime.now(),
//     });
//   }

//   Future<void> deleteBlog(String id) async {
//     await _firestore.collection('blogs').doc(id).delete();
//   }

//   Stream<List<BlogModel>> getAllBlogs() {
//     return _firestore
//         .collection('blogs')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs.map((doc) {
//             return BlogModel.fromMap(doc.data(), doc.id);
//           }).toList();
//         });
//   }

//   Stream<List<BlogModel>> getBlogsByCategory(String categoryId) {
//     return _firestore
//         .collection('blogs')
//         .where('categoryId', isEqualTo: categoryId)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//           return snapshot.docs.map((doc) {
//             return BlogModel.fromMap(doc.data(), doc.id);
//           }).toList();
//         });
//   }

//   Future<BlogModel?> getBlogById(String id) async {
//     DocumentSnapshot doc = await _firestore.collection('blogs').doc(id).get();
//     if (doc.exists) {
//       return BlogModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//     }
//     return null;
//   }

//   Future<void> incrementBlogViews(String id) async {
//     await _firestore.collection('blogs').doc(id).update({
//       'views': FieldValue.increment(1),
//     });
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';
import '../models/blog_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Management
  Stream<List<UserModel>> getAllUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> updateUserStatus(String userId, bool isActive) async {
    await _firestore.collection('users').doc(userId).update({
      'isActive': isActive,
    });
  }

  // Category CRUD
  Future<void> addCategory(String name, String description) async {
    await _firestore.collection('categories').add({
      'name': name,
      'description': description,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> updateCategory(
    String id,
    String name,
    String description,
  ) async {
    await _firestore.collection('categories').doc(id).update({
      'name': name,
      'description': description,
      'updatedAt': DateTime.now(),
    });
  }

  Future<void> deleteCategory(String id) async {
    await _firestore.collection('categories').doc(id).delete();
  }

  Stream<List<CategoryModel>> getCategories() {
    return _firestore
        .collection('categories')
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return CategoryModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  // Blog CRUD
  Future<void> addBlog(Map<String, dynamic> blogData) async {
    await _firestore.collection('blogs').add({
      ...blogData,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
      'views': 0,
    });
  }

  Future<void> updateBlog(String id, Map<String, dynamic> blogData) async {
    await _firestore.collection('blogs').doc(id).update({
      ...blogData,
      'updatedAt': DateTime.now(),
    });
  }

  Future<void> deleteBlog(String id) async {
    await _firestore.collection('blogs').doc(id).delete();
  }

  Stream<List<BlogModel>> getAllBlogs() {
    return _firestore
        .collection('blogs')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return BlogModel.fromMap(doc.data(), doc.id);
          }).toList();
        });
  }

  Future<BlogModel?> getBlogById(String id) async {
    DocumentSnapshot doc = await _firestore.collection('blogs').doc(id).get();
    if (doc.exists) {
      return BlogModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<void> incrementBlogViews(String id) async {
    await _firestore.collection('blogs').doc(id).update({
      'views': FieldValue.increment(1),
    });
  }
}
