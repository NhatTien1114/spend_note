import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String _id;
  final double _amount;
  final String _categoryId;
  final String _tagId;
  final String _walletId;
  final DateTime _dateTime;
  final String _note;

  String get id => _id;

  double get amount => _amount;

  String get categoryId => _categoryId;

  String get tagId => _tagId;

  String get walletId => _walletId;

  DateTime get dateTime => _dateTime;

  String get note => _note;

  Expense({
    required String id,
    required double amount,
    required String categoryId,
    required String tagId,
    required String walletId,
    required DateTime dateTime,
    required String note,
  }) : _id = id,
       _amount = amount,
       _categoryId = categoryId,
       _tagId = tagId,
       _walletId = walletId,
       _dateTime = dateTime,
       _note = note;

  factory Expense.fromMap(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] ?? '',
      amount: json['amount'],
      categoryId: json['categoryId'],
      tagId: json['tagId'],
      walletId: json['walletId'],
      dateTime: json['dateTime'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'amount': _amount,
      'categoryId': _categoryId,
      'tagId': _tagId,
      'walletId': _walletId,
      'dateTime': _dateTime,
      'note': _note,
    };
  }
}
