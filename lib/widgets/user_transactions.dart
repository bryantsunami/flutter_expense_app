import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> _userTransactions;

  UserTransactions(this._userTransactions);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionList(_userTransactions),
      ],
    );
  }
}
