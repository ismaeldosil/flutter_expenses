import './widgets/user_transaction.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.purple,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
          headline2: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
          headline3: TextStyle(
            fontSize: 20,
          ),
          headline4: TextStyle(
            fontSize: 16,
          ),
          headline5: TextStyle(
            fontSize: 12,
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.purple,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          bodyText2: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void _startAddNewTransaction(BuildContext ctx, Function addTx) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: ctx,
        builder: (bctx) {
          return NewTransaction(addTx);
        });
  }

  final List<Transaction> _userTransactions = [];
  //   Transaction(
  //     id: 't1',
  //     title: 'New shoes',
  //     amount: 99.99,
  //     date: DateTime.now(),
  //   ),
  //   Transaction(
  //     id: 't2',
  //     title: 'Weekly groceries',
  //     amount: 15.99,
  //     date: DateTime.now(),
  //   ),
  // ];

  List<Transaction> get _resentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context, _addNewTransaction);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(
              recentTransactions: _resentTransactions,
            ),
            UserTransaction(
              addTx: _addNewTransaction,
              transactions: _userTransactions,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _startAddNewTransaction(context, _addNewTransaction);
          },
          child: IconButton(
              icon: Icon(Icons.add),
              onPressed: (() {
                _startAddNewTransaction(context, _addNewTransaction);
              }))),
    );
  }
}
