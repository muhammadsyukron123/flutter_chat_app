import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String text,
    required String userId,
    required String username,
    required String userImage,
  }) async {
    try {
      await _firestore.collection('chat').add({
        'text': text,
        'createdAt': Timestamp.now(),
        'userId': userId,
        'username': username,
        'userImage': userImage,
      });
    } catch (e) {
      throw e;
    }
  }

  Stream<QuerySnapshot> getChatMessagesStream() {
    return _firestore
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
