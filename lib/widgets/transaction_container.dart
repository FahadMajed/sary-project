import 'package:flutter/material.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/screens/transaction_details_screen.dart';

import 'main_container.dart';

class TransactionContainer extends StatelessWidget {
  final Transaction transaction;

  const TransactionContainer({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isInbound = transaction.type == TransactionType.inbound;

    return Column(
      children: [
        MainContainer(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TransactionDetailsScreen(transaction: transaction))),
          height: 122,
          widgets: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(transaction.item.name),
                const Spacer(
                  flex: 1,
                ),
                Text("Stock ${isInbound ? "In" : "Out"}",
                    style: Theme.of(context).textTheme.subtitle1),
                RotatedBox(
                  quarterTurns: isInbound ? 1 : -1,
                  child: Icon(Icons.trending_flat,
                      color: isInbound ? Colors.green : Colors.red),
                )
              ],
            ),
            const Spacer(flex: 1),
            Text(transaction.item.sku,
                style: Theme.of(context).textTheme.subtitle2),
            Text(transaction.item.description,
                style: Theme.of(context).textTheme.subtitle2),
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(transaction.item.price.toString(),
                    style: Theme.of(context).textTheme.subtitle1),
                Text(
                    isInbound
                        ? transaction.inboundAt.toString().substring(0, 10)
                        : transaction.outboundAt.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.subtitle2)
              ],
            )
          ],
        ),
        const SizedBox(
          height: 14,
        )
      ],
    );
  }
}
