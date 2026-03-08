import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spend_note/data/firebase/firestore.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> Login({required String emai, required String password}) async{
    try {
      await _auth.signInWithEmailAndPassword(email: emai.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      throw "Lỗi: ${e.message}";
    }
  }

  Future<void> Singin({
    required String email,
    required String password,
    required String passwordConfirm,
    required String name,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty || name.isEmpty) {
        throw "Vui lòng nhập đầy đủ thông tin";
      }
      if (password != passwordConfirm) {
        throw "Mật khẩu xác nhận không khớp";
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;

        await FireStore().CreateUser(
          uid: uid,
          email: email.trim(),
          name: name.trim(),
          photoURL: userCredential.user!.photoURL ?? "",
          provider: "email",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'Mật khẩu quá yếu';
      }
      throw "${e.message}";
    } catch (e) {
      throw "Lỗi hệ thống: $e";
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }

  }
}