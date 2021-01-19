import 'package:expenses/models/transactions.dart';

class TodoList {
  List<Transactions> items;

  TodoList() {
    items = new List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
