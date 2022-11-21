import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredDate = double.parse(amountController.text);

    widget.newTransaction(
      enteredTitle,
      enteredDate,
    );
    Navigator.of(context).pop();
  }

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
                onPressed: submitData,
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
