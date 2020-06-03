import '../models/transaction.dart';

import 'transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatelessWidget {
  final Function addTx;
  final List<Transaction> transactions;

  const UserTransaction({Key key, this.addTx, this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          //NewTransaction(addTx),
          TransactionList(transactions),
        ],
      ),
    );
  }
}
