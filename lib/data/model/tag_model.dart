import 'package:flutter/cupertino.dart';

class Tag {
  final String _id;
  final String _name;
  final IconData _icon;
  final Color _color;

  String get id => _id;
  String get name => _name;
  IconData get icon => _icon;
  Color get color => _color;

  Tag({
    String id = '',
    required String name,
    required IconData icon,
    required Color color,
  }) :  _id = id,
        _name = name,
        _icon = icon,
        _color = color;


  factory Tag.fromMap(Map<String, dynamic> json, String documentId) {
    return Tag(
      id: documentId,
      name: json['name'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(json['color']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'icon': _icon.codePoint,
      'color': _color.value,
    };
  }
}