import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deteleTrans,
  }) : super(key: key);

  final Transactions userTransaction;
  final Function deteleTrans;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(child: Text('\$${userTransaction.amount}')),
          ),
        ),
        title: Text(
          userTransaction.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => deteleTrans(userTransaction.id),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deteleTrans(userTransaction.id),
              ),
      ),
    );
  }
}
