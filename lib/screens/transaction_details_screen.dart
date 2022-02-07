import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sary_project/constants/constants.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/services.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/widgets/main_container.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Item item = transaction.item;
    final bool isInbound = transaction.type == TransactionType.inbound;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
        actions: [
          IconButton(
              onPressed: () async {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                    actions: [
                      CupertinoActionSheetAction(
                        child: Text(
                          "Delete Transaction",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        onPressed: () async => await Services()
                            .deleteTransaction(transaction)
                            .then((value) => Functions.showSuccessSnackBar(
                                context,
                                "Transaction Deleted",
                                () => Navigator.popUntil(
                                    context, (route) => route.isFirst))),
                      ),
                    ],
                    cancelButton: TextButton(
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                );
              },
              icon: const Icon(FontAwesomeIcons.ellipsisH))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: MainContainer(
          widgets: [
            Row(
              children: [
                Image.memory(item.imagePath),
                const Spacer(
                  flex: 1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(item.name),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.sku,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                const Spacer(
                  flex: 7,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                HeaderWithDesc(
                    header: transaction.quantity.toString(),
                    desc: "Quanitity",
                    isLarge: true),
                const Spacer(
                  flex: 2,
                ),
                HeaderWithDesc(
                    header: item.price.toString(),
                    desc: "Price",
                    isLarge: true),
                const Spacer(
                  flex: 3,
                ),
                Text("Stock ${isInbound ? "In" : "Out"}",
                    style: Theme.of(context).textTheme.headline5),
                RotatedBox(
                  quarterTurns: isInbound ? 1 : -1,
                  child: Icon(Icons.trending_flat,
                      color: isInbound ? Colors.green : Colors.red),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            BoundData(date: transaction.inboundAt, isInbound: true),
            const SizedBox(
              height: 30,
            ),
            BoundData(date: transaction.outboundAt, isInbound: false),
          ],
        ),
      ),
    );
  }
}

class BoundData extends StatelessWidget {
  const BoundData({Key? key, required this.date, required this.isInbound})
      : super(key: key);

  final DateTime date;
  final bool isInbound;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isInbound ? "Inbound" : "Outbound",
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            HeaderWithDesc(
              header: date.toString().substring(0, 10),
              desc: "Date",
            ),
            const Spacer(
              flex: 2,
            ),
            HeaderWithDesc(
              header: date.toString().substring(11, 16),
              desc: "Time",
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderWithDesc extends StatelessWidget {
  final String header;
  final String desc;
  final bool isLarge;

  const HeaderWithDesc(
      {Key? key,
      required this.header,
      required this.desc,
      this.isLarge = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header,
            style: isLarge
                ? Theme.of(context).textTheme.headline4
                : Theme.of(context).textTheme.headline5),
        Text(desc,
            style: !isLarge
                ? Theme.of(context).textTheme.bodyText1
                : Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16))
      ],
    );
  }
}
