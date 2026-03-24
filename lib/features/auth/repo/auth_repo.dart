import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authState => _auth.authStateChanges();

  Future<User?> signUp(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    await _db.collection('users').doc(cred.user!.uid).set({
      'email' : email,
      'createdAt' : FieldValue.serverTimestamp(),
    });

    return cred.user;
  }

  Future<User?> login(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);

    return cred.user;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  } 
}