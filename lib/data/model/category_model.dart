import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spend_note/data/model/tag_model.dart';

class CategoryGroup {
  final String _id;
  final String _name;
  final IconData _groupIcon;
  final List<Tag> _tags;
  final Color _color;
  final String _type;

  String get id => _id;

  String get name => _name;

  IconData get groupIcon => _groupIcon;

  List<Tag> get tags => _tags;

  Color get color => _color;

  String get type => _type;

  CategoryGroup({
    required String id,
    required String name,
    required IconData groupIcon,
    required List<Tag> tags,
    required Color color,
    required String type,
  }) : _id = id,
       _name = name,
       _groupIcon = groupIcon,
       _tags = tags,
      _color = color,
       _type = type;

  factory CategoryGroup.fromMap(Map<String, dynamic> json) {
    return CategoryGroup(
      id: json['id'] ?? '',
      name: json['name'],
      groupIcon: json['groupIcon'],
      tags: json['tags'],
      color: json['color'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'groupIcon': _groupIcon,
      'tags': _tags,
      'color': _color,
      'type': _type,
    };
  }
}
