class Wallet {
  final String _id;
  final double _amount;
  final String _name;
  final String _type;
  final String _currency;
  final String _note;

  String get id => _id;

  double get amount => _amount;

  String get name => _name;

  String get type => _type;

  String get currency => _currency;

  String get note => _note;

  Wallet({
    required String id,
    required double amount,
    required String name,
    required String type,
    required String currency,
    required String note,
  })
      : _id = id,
        _amount = amount,
        _name = name,
        _type = type,
        _currency = currency,
        _note = note;

  factory Wallet.fromMap(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'] ?? '',
      amount: json['amount'],
      name: json['name'],
      type: json['type'],
      currency: json['currency'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'amount': _amount,
      'name': _name,
      'type': _type,
      'currency': _currency,
      'note': _note,
    };
  }
}
