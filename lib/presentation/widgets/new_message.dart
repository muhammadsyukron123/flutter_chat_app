//new_message
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  File? _pickedImageFile;
  final _messageController = TextEditingController();



  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  // void _submitMessage() async {
  //   final enteredMessage = _messageController.text;
  //
  //   if (enteredMessage.trim().isEmpty) {
  //     return;
  //   }
  //
  //   FocusScope.of(context).unfocus();
  //   _messageController.clear();
  //
  //   final user = FirebaseAuth.instance.currentUser!;
  //   final userData = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .get();
  //
  //   FirebaseFirestore.instance.collection('chat').add({
  //     'text': enteredMessage,
  //     'createdAt': Timestamp.now(),
  //     'userId': user.uid,
  //     'username': userData.data()!['username'],
  //     'userImage': userData.data()!['image_url'],
  //   });
  // }

  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty && _pickedImageFile == null) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();


    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (_pickedImageFile != null) {
      // Handle image messages
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('chat_images')
          .child('${DateTime.now().toIso8601String()}.jpg');

      await storageRef.putFile(_pickedImageFile!);
      final imageUrl = await storageRef.getDownloadURL();

      FirebaseFirestore.instance.collection('chat').add({
        'imageUrl': imageUrl,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData.data()!['username'],
        'userImage': userData.data()!['image_url'],
      });

      _pickedImageFile = null;
    } else {
      // Handle text messages
      FirebaseFirestore.instance.collection('chat').add({
        'text': enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData.data()!['username'],
        'userImage': userData.data()!['image_url'],
      });
    }
  }


  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, // Mengambil gambar dari galeri
      imageQuality: 50,
      // maxWidth: 150,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
            //   Buatlah sebuah fungsi untuk memilih gambar dari galeri
                _pickImage();
            },
            icon: const Icon(Icons.camera_alt),
          ),
          Container(
            child: _pickedImageFile != null
                ? Image.file(
              _pickedImageFile!,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ) : Text(''),
          ),
          Expanded(
            child:
            TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(
              Icons.send,
            ),
            onPressed: _submitMessage,
          ),

        ],
      ),
    );
  }
}