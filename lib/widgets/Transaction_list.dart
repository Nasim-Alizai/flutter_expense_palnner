import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;

  final Function deteleTrans;

  const TransactionList(this.userTransactions, this.deteleTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: userTransactions.isEmpty
            ? Column(
                children: [
                  Text("No transactions added yet !"),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
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
                              child:
                                  Text('\$${userTransactions[index].amount}')),
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
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () =>
                            deteleTrans(userTransactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: userTransactions.length,
              ));
  }
}
