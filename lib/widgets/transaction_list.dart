import 'package:expenses/models/transactions.dart';
import 'package:expenses/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('transaction list');
    return transactions.isEmpty
        ? Column(
            children: [
              Text("No transaction is addeed!"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.pngg',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView(
            children: transactions
                .map((e) => Transaction_card(
                      key: ValueKey(e.id),
                      transaction: e,
                      deleteTx: deleteTx,
                    ))
                .toList(),
          );
  }
}
