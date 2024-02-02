import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadUserImage(File imageFile, String userId) async {
    try {
      final storageRef = _firebaseStorage
          .ref()
          .child('user_images')
          .child('$userId.jpg');

      final uploadTask = storageRef.putFile(imageFile);
      await uploadTask;
      final imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw e;
    }
  }
}
