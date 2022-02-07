import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sary_project/constants/constants.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/services.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/shared/bordered_text_field.dart';
import 'package:sary_project/shared/cupertino_bs_container.dart';
import 'package:sary_project/widgets/main_container.dart';
import 'package:sary_project/widgets/transaction_button.dart';

// ignore: must_be_immutable
class AddTransactionScreen extends StatelessWidget {
  final Item item;
  final TransactionType type;
  const AddTransactionScreen({Key? key, required this.item, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int quantity = 0;
    DateTime boundDate = DateTime.now();
    final isInbound = type == TransactionType.inbound ? true : false;
    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Add Transaction"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MainContainer(widgets: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.memory(item.imagePath),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: BorderedTextField(
                      labelText: "Quanitity",
                      inputType: TextInputType.number,
                      onChanged: (quan) {
                        quantity = int.tryParse(quan) as int;
                      }),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  isInbound ? "Inbound At:" : "Outbound At:",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoBSContainer(
                              child: CupertinoDatePicker(
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime value) =>
                                setState(() => boundDate = value),
                          ))),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(boundDate.toString().substring(0, 16)),
                    ),
                  ),
                )
              ],
            )
          ]),
        ),
        floatingActionButton: ActionButton(
          title: "Submit",
          iconData: Icons.check,
          scalar: 0.9,
          onTap: () {
            Transaction txn = Transaction(
                id: boundDate.toString(),
                type: type,
                item: item,
                quantity: quantity,
                inboundAt: boundDate,
                outboundAt: boundDate,
                createdAt: DateTime.now());
            Services().addTransaction(txn);
            Functions.showSuccessSnackBar(context, "Transaction Added",
                () => Navigator.popUntil(context, (route) => route.isFirst));
          },
        ),
      );
    });
  }
}
