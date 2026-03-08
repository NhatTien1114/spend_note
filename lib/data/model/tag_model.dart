import 'package:flutter/cupertino.dart';

class Tag {
  final String _name;
  final IconData _icon;
  final Color _color;

  String get name => _name;
  IconData get icon => _icon;
  Color get color => _color;

  Tag({
    required String name,
    required IconData icon,
    required Color color,
  }) :  _name = name,
        _icon = icon,
        _color = color;


  factory Tag.fromMap(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      icon: json['icon'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'icon': _icon,
      'color': _color,
    };
  }
}