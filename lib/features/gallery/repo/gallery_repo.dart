import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:void_vault/features/gallery/model/cloudinary_account.dart';

class GalleryRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String cloudName = 'dl5irrv3i';
  final String uploadPreset = 'VaultxVisuals';

  Future<String> uploadToCloudinary(File file, String cloudName, String uploadPreset) async {
    String url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    FormData formData = FormData.fromMap({
      'file' : await MultipartFile.fromFile(file.path),
      'upload_preset' : uploadPreset,
    });

    Response res = await Dio().post(url, data: formData);

    return res.data['secure_url'];
  }

  Future<void> saveImage(String imageUrl, String accountId) async {
    final user = _auth.currentUser;
    await _db.collection('images').add({
      'userId' : user!.uid,
      'imageUrl' : imageUrl,
      'accountId' : accountId,
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

  Stream<List<CloudinaryAccount>> getAccounts(){
    return _db.collection('cloudinary_accounts').snapshots().map((snap){
      return snap.docs.map((doc){
        return CloudinaryAccount.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> incrementStorage(String accountId) async {
    await _db.collection('cloudinary_accounts').doc(accountId).update({
      'usedStorage' : FieldValue.increment(1)
    });
  }

  Future<void> addAccount(CloudinaryAccount account) async {
    final user = _auth.currentUser;
    await _db.collection('cloudinary_accounts').add({
      'userId' : user!.uid,
      'cloudName' : account.cloudName,
      'uploadPreset' : account.uploadPreset,
      'label' : account.label,
      'usedStorage' : 0,

    });
  }

  Future<void> deleteAccount(String accountId) async {
    await _db.collection('cloudinary_accounts').doc(accountId).delete();
  }
}