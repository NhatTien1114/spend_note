import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStore {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser({
    required String uid,
    required String email,
    required String name,
    required String photoURL,
    required String provider,
}) async {
    await _firebaseFirestore.collection("users").doc(_auth.currentUser!.uid).set({
      "uid": uid,
      "email": email,
      "name": name,
      "photoURL": photoURL,
      "provider": provider,
      "createAt": DateTime.now().toUtc().millisecondsSinceEpoch,
    });
    return true;
  }
}