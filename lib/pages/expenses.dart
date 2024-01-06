import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import '../components/boxes.dart';
import '../components/transaction_dialog.dart';
import '../model/transaction.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  static const _color = const Color(0xff008037);

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text("Expenses"),
              centerTitle: true,
            ),
            body: ValueListenableBuilder<Box<Transaction>>(
              valueListenable: Hive.box<Transaction>('transactions').listenable(),
              builder: (context, box, _) {
                final _transactions = box.values.toList().cast<Transaction>();
                _transactions.sort(
                      (transaction1, transaction2) =>
                      transaction2.createdDate.compareTo(transaction1.createdDate),
                );

                return _buildContents(_transactions);
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: _color,
              onPressed: () async {
                final result = await showDialog(
                  context: context,
                  builder: (context) {
                    return TransactionDialog(
                      onClickedDone: (name, amount, isExpense) {
                        _addTransaction(name, amount, isExpense);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContents(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          "Empty",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      final netExpense = transactions.fold<double>(
        0,
            (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount,
      );

      final color = netExpense > 0 ? _color : Colors.red;
      return Padding(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            Text(
              "Net Expenses : \$ $netExpense",
              style: TextStyle(
                color: color,
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];

                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(color: Colors.red),
                    onDismissed: (_) {
                      _deleteTransaction(transaction);
                    },
                    child: _buildTransaction(context, transaction),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildTransaction(BuildContext context, Transaction transaction) {
    final color = transaction.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(transaction.createdDate);
    final amount = "\$ ${transaction.amount}";
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: Text(
            transaction.name,
            maxLines: 2,
            style: TextStyle(
              color: _color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            date,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          trailing: Text(
            amount,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _addTransaction(String name, double amount, bool isExpense) {
    final transaction = Transaction()
      ..name = name
      ..amount = amount
      ..isExpense = isExpense
      ..createdDate = DateTime.now();

    final box = Hive.box<Transaction>('transactions');
    box.add(transaction);
  }

  void _deleteTransaction(Transaction transaction) {
    final box = Hive.box<Transaction>('transactions');
    box.delete(transaction.key);
  }
}
