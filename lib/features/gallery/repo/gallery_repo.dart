import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GalleryRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String cloudName = 'dl5irrv3i';
  final String uploadPreset = 'VaultxVisuals';

  Future<String> uploadToCloudinary(File file) async {
    String url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    FormData formData = FormData.fromMap({
      'file' : await MultipartFile.fromFile(file.path),
      'upload_preset' : uploadPreset,
    });

    Response res = await Dio().post(url, data: formData);

    return res.data['secure_url'];
  }

  Future<void> saveImage(String imageUrl) async {
    final user = _auth.currentUser;
    await _db.collection('images').add({
      'userId' : user!.uid,
      'imageUrl' : imageUrl,
      'createdAt' :FieldValue.serverTimestamp(),
    });

  }

  Stream<QuerySnapshot> getImages() {
    final user = _auth.currentUser;

    return _db
        .collection('images')
        .where('userId', isEqualTo: user!.uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

}