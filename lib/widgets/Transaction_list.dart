import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;

  final Function deteleTrans;

  const TransactionList(this.userTransactions, this.deteleTrans);

  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (cts, cnt) {
            return Column(
              children: [
                Text("No transactions added yet !"),
                SizedBox(
                  height: 10,
                ),
                Container(
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
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$${userTransactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () =>
                              deteleTrans(userTransactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.purple),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () =>
                              deteleTrans(userTransactions[index].id),
                        ),
                ),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
