import 'package:flutter/material.dart';

import '../models/transactions.dart';
import '../widgets/new_transaction.dart';
import '../widgets/Transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(
          _userTransactions,
        ),
      ],
    );
  }
}
