import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/Transaction_list.dart';
import './models/transactions.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

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
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
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

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Increase volume by 10',
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.brown,
              elevation: 5,
              child: Text("this is Nasim"),
            ),
          ),
          TransactionList(
            _userTransactions,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}