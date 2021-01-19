import 'dart:math';

import 'package:expenses/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_card extends StatefulWidget {
  const Transaction_card({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transactions transaction;
  final Function deleteTx;

  @override
  _Transaction_cardState createState() => _Transaction_cardState();
}

class _Transaction_cardState extends State<Transaction_card> {
  Color bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
    ];
    bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      elevation: 10,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: FittedBox(child: Text('\$ ${widget.transaction.amount}')),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).orientation == Orientation.portrait
            ? IconButton(
                color: Colors.red,
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTx(widget.transaction.id);
                },
              )
            : FlatButton.icon(
                onPressed: () {
                  widget.deleteTx(widget.transaction.id);
                },
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Colors.red,
              ),
      ),
    );
  }
}
