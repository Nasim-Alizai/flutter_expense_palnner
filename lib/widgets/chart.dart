import 'package:flutter/material.dart';
import 'package:flutter_expense_palnner/models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTrans;
  const Chart(this.recentTrans);

  List<Map<String, Object>> get maptrans {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double amountSum = 0.0;

      for (var i = 0; i < recentTrans.length; i++) {
        if (recentTrans[i].date.day == weekDay.day &&
            recentTrans[i].date.month == weekDay.month &&
            recentTrans[i].date.year == weekDay.year) {
          amountSum += recentTrans[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amountSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Row(
        children: maptrans.map((e) {
          return Text('${e['day']}: ${e['amount'].toString()}');
        }).toList(),
      ),
    );
  }
}
