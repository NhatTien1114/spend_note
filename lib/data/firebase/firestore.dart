import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spend_note/data/model/category_model.dart';
import 'package:spend_note/data/model/tag_model.dart';

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
    await _firebaseFirestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set({
          "uid": uid,
          "email": email,
          "name": name,
          "photoURL": photoURL,
          "provider": provider,
          "createAt": DateTime.now().toUtc().millisecondsSinceEpoch,
        });
    return true;
  }

//   =========================== CATEGORY CRUD ===========================
  Future<bool> addCategory(CategoryGroup category) async {
    await _firebaseFirestore
        .collection('categories')
        .doc(_auth.currentUser!.uid)
        .set({
      'name': category.name,
      'groupIcon': category.groupIcon.codePoint,
      'tags': category.tags.map((tag) => tag.toMap()).toList(),
      'color': category.color.value,
      'type': category.type,
    });
    return true;
  }

  // Trong class FireStore
  Stream<List<CategoryGroup>> getCategories() {
    return _firebaseFirestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CategoryGroup.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<bool> updateCategory(CategoryGroup category) async {
    await _firebaseFirestore
        .collection('categories')
        .doc(_auth.currentUser!.uid)
        .collection('categories')
        .doc(category.id)
        .update({
      'name': category.name,
      'groupIcon': category.groupIcon.codePoint,
      'tags': category.tags.map((tag) => tag.toMap()).toList(),
      'color': category.color.value,
      'type': category.type,
    });
    return true;
  }

  Future<bool> deleteCategory(String categoryId) async {
    await _firebaseFirestore
        .collection('categories')
        .doc(_auth.currentUser!.uid)
        .collection('categories')
        .doc(categoryId)
        .delete();
    return true;
  }

  // =========================== TAG CRUD ===========================
  Future<bool> addTag (Tag tag) async {
    await _firebaseFirestore
        .collection('tags')
        .doc(_auth.currentUser!.uid)
        .set({
      'name': tag.name,
      'icon': tag.icon.codePoint,
      'color': tag.color.value,
    });
    return true;
  }

  Stream<List<Tag>> getTags() {
    return _firebaseFirestore.collection('tags').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Tag.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<bool> updateTag(Tag tag) async{
    await _firebaseFirestore
        .collection('tags')
        .doc(_auth.currentUser!.uid)
        .collection('tags')
        .doc(tag.id)
        .update({
      'name': tag.name,
      'icon': tag.icon.codePoint,
      'color': tag.color.value,
    });
    return true;
  }

  Future<bool> deleteTag(String tagId) async {
    await _firebaseFirestore
        .collection('tags')
        .doc(_auth.currentUser!.uid)
        .collection('tags')
        .doc(tagId)
        .delete();
    return true;
  }
}
