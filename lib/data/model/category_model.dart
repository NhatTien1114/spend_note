import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  factory CategoryGroup.fromMap(Map<String, dynamic> json, String documentId) {
    return CategoryGroup(
      id: documentId,
      name: json['name'] ?? '',
      groupIcon: IconData(json['groupIcon'], fontFamily: 'MaterialIcons'),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((item) => Tag.fromMap(item as Map<String, dynamic>, documentId))
          .toList() ?? [],
      color: Color(json['color']),
      type: json['type'] ?? 'expense',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'groupIcon': _groupIcon.codePoint,
      'tags': _tags.map((tag) => tag.toMap()).toList(),
      'color': _color.value,
      'type': _type,
    };
  }
}
