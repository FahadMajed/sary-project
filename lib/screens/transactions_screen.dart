import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/main.dart';
import 'package:sary_project/models/services.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/widgets/filter_icon.dart';
import 'package:sary_project/widgets/search_field.dart';
import 'package:sary_project/widgets/transaction_button.dart';
import 'package:sary_project/widgets/transaction_container.dart';

import 'new_txn_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String searchTerm = "";
    FilterBy filterBy = FilterBy.None;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transactions",
        ),
        actions: const [AddItemIcon()],
      ),
      body: StatefulBuilder(builder: (context, setState) {
        return ValueListenableBuilder<Box<Transaction>>(
          valueListenable: transactionBox.listenable(),
          builder: (context, box, child) => Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: SearchField(
                            onChanged: (term) =>
                                setState(() => searchTerm = term))),
                    const SizedBox(
                      width: 24,
                    ),
                    FilterIcon(
                      onPressed: (FilterBy newFilterBy) {
                        setState(() => filterBy = newFilterBy);
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 21,
                ),
                Expanded(
                  child: ListView(
                    children: box.values.isEmpty
                        ? const [Center(child: Text("No Transactions Yet"))]
                        : Services()
                            .getTransactions(filterBy, searchTerm)
                            .map((transaction) =>
                                TransactionContainer(transaction: transaction))
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ActionButton(
              scalar: 0.45,
              iconData: Icons.trending_flat,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const NewTransactionScreen(action: "Send"))),
              quarterTurns: -1,
              title: "Send"),
          const SizedBox(
            width: 6,
          ),
          ActionButton(
            scalar: 0.45,
            iconData: Icons.trending_flat,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const NewTransactionScreen(action: "Recieve"))),
            quarterTurns: 1,
            title: "Recieve",
          ),
        ],
      ),
    );
  }
}

class AddItemIcon extends StatelessWidget {
  const AddItemIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "items_screen"),
      child: SizedBox(
        width: 50,
        child: Stack(children: const [
          Positioned(
            left: 2,
            top: 15,
            child: Icon(
              Icons.local_offer,
              size: 20,
            ),
          ),
          Positioned(
            left: 8,
            top: 10,
            child: Icon(
              Icons.add,
              size: 28,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 11,
            top: 15,
            child: Icon(
              Icons.add,
              size: 18,
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }
}
