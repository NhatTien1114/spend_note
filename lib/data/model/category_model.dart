class Category {
  final String _id;
  final String _name;
  final String _tagId;
  final String _type;

  String get id => _id;

  String get name => _name;

  String get tagId => _tagId;

  String get type => _type;

  Category({
    required String id,
    required String name,
    required String tagId,
    required String type,
  }) : _id = id,
       _name = name,
       _tagId = tagId,
       _type = type;

  factory Category.fromMap(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      name: json['name'],
      tagId: json['tagId'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'tagId': _tagId,
      'type': _type,
    };
  }
}
