import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/Transaction_list.dart';
import './models/transactions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  final List<Transactions> _userTransactions = [
    Transactions(
      id: 't1',
      title: "new shoes",
      amount: 99.9,
      date: DateTime.now(),
    ),
    Transactions(
      id: 't2',
      title: "new book",
      amount: 9.98,
      date: DateTime.now(),
    )
  ];

  bool _showGraph = false;

  List<Transactions> get _recentTrans {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTrans(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mdQuery = MediaQuery.of(context);
    final land = MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text("Personal Expense"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text('Expense Planner'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Increase volume by 10',
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          ) as PreferredSizeWidget);

    final txListWidget = SizedBox(
      height: (mdQuery.size.height -
              appBar.preferredSize.height -
              mdQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTrans),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            if (land)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "show Graph",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Switch.adaptive(
                    value: _showGraph,
                    onChanged: (val) {
                      setState(() {
                        _showGraph = val;
                      });
                    },
                  )
                ],
              ),
            if (land)
              _showGraph
                  ? SizedBox(
                      height: (mdQuery.size.height -
                              appBar.preferredSize.height -
                              mdQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTrans),
                    )
                  : txListWidget,
            if (!land)
              SizedBox(
                height: (mdQuery.size.height -
                        appBar.preferredSize.height -
                        mdQuery.padding.top) *
                    0.3,
                child: Chart(_recentTrans),
              ),
            if (!land) txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: (appBar as ObstructingPreferredSizeWidget),
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(Icons.add),
                  ),
          );
  }
}
