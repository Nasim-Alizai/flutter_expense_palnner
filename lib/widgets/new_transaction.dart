import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'amount'),
              controller: amountController,
            ),
            TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                ),
                onPressed: () {
                  newTransaction(
                    titleController.text,
                    double.parse(amountController.text),
                  );
                },
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
