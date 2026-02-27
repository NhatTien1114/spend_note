import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String _uid;
  final String _email;
  final String _name;
  final String _photoURL;
  final String _provider;
  final DateTime? _createAt;

  String get uid => _uid;
  String get email => _email;
  String get name => _name;
  String get photoURL => _photoURL;
  String get provider => _provider;
  DateTime? get createAt => _createAt;

  User({
    required String uid,
    required String email,
    required String name,
    required String photoURL,
    required String provider,
    DateTime? createAt,
  }) : _uid = uid,
        _email = email,
        _name = name,
        _photoURL = photoURL,
        _provider = provider,
        _createAt = createAt;


  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] ?? '',
      email: json['email'],
      name: json['name'],
      photoURL: json['photoURL'],
      provider: json['provider'],
      createAt: (json['createAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': _uid,
      'email': _email,
      'name': _name,
      'photoURL': _photoURL,
      'provider': _provider,
      'createAt': _createAt,
    };
  }
}