import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  Widget _createRow(BuildContext context, Transaction tx) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 15,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
          ),
          child: Text(
            "\$ ${tx.amount.toStringAsFixed(2)}",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              tx.title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              DateFormat.yMMMEd().format(tx.date),
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? Container(
            height: 530,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return _createRow(ctx, transactions[index]);
              },
              itemCount: transactions.length,
            ))
        : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Theres no transactions yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                )
              ],
            ),
          );
  }
}
