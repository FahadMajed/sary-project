import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/widgets/item_container.dart';
import 'package:sary_project/widgets/search_field.dart';

import '../main.dart';
import 'add_txn_screen.dart';

class NewTransactionScreen extends StatelessWidget {
  final String action;
  const NewTransactionScreen({Key? key, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionType type =
        action == "Send" ? TransactionType.outbound : TransactionType.inbound;
    String searchTerm = "";
    return StatefulBuilder(builder: (context, setState) {
      return Scaffold(
          appBar: AppBar(
            title: Text("$action Item"),
          ),
          body: ValueListenableBuilder<Box<Item>>(
            valueListenable: itemsBox.listenable(),
            builder: (context, box, child) => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SearchField(
                      onChanged: (term) => setState(() => searchTerm = term)),
                  const SizedBox(
                    height: 21,
                  ),
                  Expanded(
                    child: ListView(
                      children: box.values.isEmpty
                          ? const [Center(child: Text("No Items Yet"))]
                          : box.values
                              .where((item) => item.name.contains(searchTerm))
                              .map((item) => ItemContainer(
                                    item: item,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddTransactionScreen(
                                                      item: item, type: type)));
                                    },
                                  ))
                              .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
