import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList({@required this.transactions, @required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraits) {
            return Column(
              children: <Widget>[
                Text(
                  "No transaction added yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraits.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text("\$${transactions[index].amount}")),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: mediaQuery.size.width > 360
                      ? TextButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          onPressed: () => deleteTx(transactions[index].id),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).errorColor)),
                        )
                      : IconButton(
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
