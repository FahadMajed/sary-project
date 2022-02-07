import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/constants/constants.dart';
import 'package:sary_project/main.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/services.dart';
import 'package:sary_project/widgets/item_container.dart';
import 'package:sary_project/widgets/transaction_button.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items"),
      ),
      body: ValueListenableBuilder<Box<Item>>(
        valueListenable: itemsBox.listenable(),
        builder: (context, box, child) => Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: box.values.isEmpty
                ? const [Center(child: Text("No Items Yet"))]
                : box.values
                    .map((item) => ItemContainer(
                          item: item,
                          onTap: () async {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: Text(
                                      "Delete Item",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    onPressed: () async => await Services()
                                        .deleteItem(item)
                                        .then((value) =>
                                            Functions.showSuccessSnackBar(
                                                context,
                                                "Item Deleted",
                                                () => Navigator.popUntil(
                                                    context,
                                                    (route) => route.isFirst))),
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
                        ))
                    .toList(),
          ),
        ),
      ),
      floatingActionButton: ActionButton(
        title: "Add Item",
        iconData: Icons.add,
        onTap: () => Navigator.pushNamed(context, "add_item_screen"),
        scalar: 0.9,
      ),
    );
  }
}
