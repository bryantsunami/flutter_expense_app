import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.blue,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold))),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                button: TextStyle(color: Colors.white),
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'Dog food', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't3', title: 'Toryumon', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't4', title: 'Dog food', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't5', title: 'Groceries', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't6', title: 'Toryumon', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't7', title: 'Dog food', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't8', title: 'Groceries', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't9', title: 'Toryumon', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't10', title: 'Dog food', amount: 49.99, date: DateTime.now()),
    Transaction(
        id: 't12', title: 'Groceries', amount: 70.38, date: DateTime.now()),
    Transaction(
        id: 't13', title: 'Toryumon', amount: 70.38, date: DateTime.now()),
  ];

  void _addNewTransaction(
      String txnTitle, double txnAmount, DateTime selectedDate) {
    final newTxn = Transaction(
      id: DateTime.now().toString(),
      title: txnTitle,
      amount: txnAmount,
      date: selectedDate,
    );

    setState(() {
      _userTransactions.add(newTxn);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((txn) => txn.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((txn) {
      return txn.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
      // backgroundColor: ,
    );

    final bodyHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  height: bodyHeight * 0.3, child: Chart(_recentTransactions)),
              Container(
                  height: bodyHeight * 0.7,
                  child:
                      TransactionList(_userTransactions, _deleteTransaction)),
            ]),
      ),
    );
  }
}
