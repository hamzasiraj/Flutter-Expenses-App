import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addtX;
  NewTransactions(this.addtX);

  @override
  _NewTransactionsState createState() => _NewTransactionsState(addtX);
}

class _NewTransactionsState extends State<NewTransactions> {
  Function addtxx;
  _NewTransactionsState(this.addtxx);
  final amountController = TextEditingController();
  DateTime _selectedDate;
  final titleController = TextEditingController();

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    addtxx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),

                // onChanged: (value) => inputTitle = value,
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                // onChanged: (value) => inputAmount = value,
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate != null
                          ? 'Picked Date: ${DateFormat.yMMMMd().format(_selectedDate)}'
                          : 'No Date Chosen!'),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Add Transaction',
                ),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
