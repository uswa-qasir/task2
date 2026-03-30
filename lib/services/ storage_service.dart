// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:uuid/uuid.dart';

// class StorageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final Uuid _uuid = Uuid();

//   Future<String> uploadImage(File imageFile, String folder) async {
//     try {
//       String fileName = '${_uuid.v4()}.jpg';
//       Reference ref = _storage.ref().child('$folder/$fileName');

//       UploadTask uploadTask = ref.putFile(imageFile);
//       TaskSnapshot snapshot = await uploadTask;

//       String downloadUrl = await snapshot.ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Error uploading image: $e');
//       rethrow;
//     }
//   }

//   Future<void> deleteImage(String imageUrl) async {
//     try {
//       if (imageUrl.isNotEmpty) {
//         await _storage.refFromURL(imageUrl).delete();
//       }
//     } catch (e) {
//       print('Error deleting image: $e');
//     }
//   }
// }
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = Uuid();

  Future<String> uploadImage(File imageFile, String folder) async {
    try {
      String fileName = '${_uuid.v4()}.jpg';
      Reference ref = _storage.ref().child('$folder/$fileName');

      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        await _storage.refFromURL(imageUrl).delete();
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}
