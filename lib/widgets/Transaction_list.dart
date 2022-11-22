// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;

  final Function deteleTrans;

  const TransactionList(this.userTransactions, this.deteleTrans, {super.key});

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (cts, cnt) {
            return Column(
              children: [
                const Text("No transactions added yet !"),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: cnt.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  userTransaction: userTransactions[index],
                  deteleTrans: deteleTrans);
            },
            itemCount: userTransactions.length,
          );
  }
}
