import 'dart:io' show Platform;
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transctions.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/transactions.dart';

void main() {
  runApp(RealPage());
}

class RealPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            theme: CupertinoThemeData(),
            home: MyHomePage(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
            ),
            home: MyHomePage(),
          );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  List<Transactions> _usersTransactions = [];
  var loading = false;
  bool booli = true;
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transactions> get _recentTransactions {
    return _usersTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newwTX = new Transactions(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toIso8601String(),
    );

    setState(() {
      _usersTransactions.add(newwTX);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTransactions(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usersTransactions.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> ifLandscape(
    MediaQueryData mediaQuery,
    AppBar appbar,
    Widget txListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch(
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.6,
              child: Chart(_recentTransactions),
            )
          : txListWidget,
    ];
  }

  List<Widget> ifPortrait(
    MediaQueryData mediaQuery,
    AppBar appbar,
    Widget txListWidget,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        )
      ],
      title: Text('Personal Expenses'),
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_usersTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandscape)
              ...ifLandscape(
                mediaQuery,
                appbar,
                txListWidget,
              ),
            if (!isLandscape)
              ...ifPortrait(
                mediaQuery,
                appbar,
                txListWidget,
              ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            }),
      ),
    );
  }
}
