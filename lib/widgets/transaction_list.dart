import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  TransactionList(this._transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text('No transactions yet',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 20),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              // final txn = ;
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(7),
                          child: FittedBox(
                            child: Text(
                                '\$${_transactions[index].amount.toStringAsFixed(2)}'),
                          ))),
                  title: Text(_transactions[index].title,
                      style: Theme.of(context).textTheme.headline6),
                  subtitle: Text(
                      DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
                          .format(_transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteTransaction(_transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: _transactions.length,
            // padding: EdgeInsets.only(bottom: 90),
          );
  }
}
