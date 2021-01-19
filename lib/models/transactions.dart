import 'package:flutter/material.dart';

class Transactions {
  String id;
  String title;
  double amount;
  DateTime date;

  Transactions(
      {@required this.id,
      @required this.amount,
      @required this.date,
      @required this.title});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['amount'] = amount;
    m['date'] = date;
    m['title'] = title;

    return m;
  }
}
