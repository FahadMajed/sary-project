import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/constants/constants.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/screens/add_item_screen.dart';
import 'package:sary_project/screens/items_screen.dart';
import 'package:sary_project/screens/transactions_screen.dart';
import 'package:sary_project/screens/txn_details_screen.dart';

import 'models/item.dart';
import 'models/services.dart';

late Box<Transaction> transactionBox;
late Box<Item> itemsBox;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  transactionBox = await Hive.openBox<Transaction>("transactions");
  Box<bool> box = await Hive.openBox<bool>("logins");

  itemsBox = await Hive.openBox<Item>("items");

  if (box.values.isEmpty) {
    ByteData bytes1 = await rootBundle.load('images/bar.png');
    ByteData bytes2 = await rootBundle.load('images/oil.png');
    await rootBundle.load('images/prin.png').then((value) {
      //demo purposes
      Item barbican = Item(
          id: "bar",
          name: "Barbican Beer Drink",
          price: 92.6,
          sku: "PRO-SA3",
          description: "320 ml x 6",
          imagePath: bytes1.buffer.asUint8List());

      Item oil = Item(
          id: "oil",
          name: "Afia Oil",
          price: 105.0,
          sku: "PRO-SA2",
          description: "400g x 12",
          imagePath: bytes2.buffer.asUint8List());

      Item prin = Item(
          id: "prin",
          name: "Pringles Potatos",
          price: 44.6,
          sku: "PRO-SA1",
          description: "150GM x 8",
          imagePath: value.buffer.asUint8List());

      Services().addItem(barbican);
      Services().addItem(oil);
      Services().addItem(prin);
    });
  }
  box.put(1, true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sarry Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(248, 248, 248, 1),
          primarySwatch: Colors.grey,
          fontFamily: "Nunito-Sans",
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, color: kTextColor),
          ),
          textTheme: const TextTheme(
            button: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 24, color: Colors.white),
            headline3: TextStyle(fontSize: 21, color: kTextColor),
            headline4: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 19, color: Colors.black),
            headline5: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 16, color: Colors.black),
            subtitle1: TextStyle(fontWeight: FontWeight.w900, fontSize: 11.5),
            subtitle2: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 12, color: kTextColor),
            bodyText1: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          snackBarTheme: SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.white,
              elevation: 3,
              contentTextStyle: const TextStyle(color: Colors.black),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            centerTitle: true,
            color: Colors.white,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 22, color: Colors.black),
          )),
      routes: {
        "main_screen": (context) => const TransactionsScreen(),
        "items_screen": (context) => const ItemsScreen(),
        "add_item_screen": (context) => AddItemScreen(),
        "txn_details_screen": (context) => const TxnDetailsScreen()
      },
      home: const TransactionsScreen(),
    );
  }
}
