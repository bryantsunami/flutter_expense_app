import 'dart:io';
import 'package:flutter/cupertino.dart';
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
    // return Platform.isIOS ? CupertinoApp(
    //   title: 'Personal Expenses',
    //   theme: CupertinoThemeData(
    //       primarySwatch: Colors.teal,
    //       accentColor: Colors.blue,
    //       fontFamily: 'Quicksand',
    //       appBarTheme: AppBarTheme(
    //           textTheme: ThemeData.light().textTheme.copyWith(
    //               headline6: TextStyle(
    //                   fontFamily: 'OpenSans',
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.bold))),
    //       textTheme: ThemeData.light().textTheme.copyWith(
    //             headline6: TextStyle(
    //                 fontFamily: 'OpenSans',
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 18),
    //             button: TextStyle(color: Colors.white),
    //           )),
    //   home: MyHomePage(),
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
  bool _showChart = false;
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

  Widget _buildCupertinoBar() {
    return CupertinoNavigationBar(
        middle: Text('Personal Expenses'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              child: Icon(
                CupertinoIcons.add,
              ),
              onTap: () => _startAddNewTransaction(context),
            )
          ],
        ));
  }

  Widget _buildMaterialBar() {
    return AppBar(
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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildCupertinoBar() : _buildMaterialBar();

    final bodyHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final txListWidget = Container(
        height: bodyHeight * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final body = SafeArea(
        child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart',
                      style: Theme.of(context).textTheme.headline6),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (isLandscape)
              _showChart
                  ? Container(
                      height: bodyHeight * 0.7,
                      child: Chart(_recentTransactions))
                  : txListWidget,
            if (!isLandscape)
              Container(
                  height: bodyHeight * 0.3, child: Chart(_recentTransactions)),
            if (!isLandscape) txListWidget,
          ]),
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: body);
  }
}
