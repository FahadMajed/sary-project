import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/main.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/services.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/widgets/filter_icon.dart';

void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(TransactionAdapter())
    ..registerAdapter(ItemAdapter())
    ..registerAdapter(TransactionTypeAdapter());

  //Always starts from a clean box
  Hive.deleteBoxFromDisk('transactions');
}

void main() async {
  initialiseHive();
  transactionBox = await Hive.openBox<Transaction>("transactions");
  itemsBox = await Hive.openBox<Item>("items");
  Item bottle = Item(
      name: "Bottle",
      id: "321",
      price: 20,
      sku: "PRO-SA5",
      description: "20 x 3",
      imagePath: Uint8List(4));
  Transaction transaction = Transaction(
      id: "123",
      type: TransactionType.inbound,
      item: bottle,
      quantity: 3,
      inboundAt: DateTime.now(),
      outboundAt: DateTime.now(),
      createdAt: DateTime.now());

  Transaction transaction2 = Transaction(
      id: "12233",
      type: TransactionType.outbound,
      item: bottle,
      quantity: 6,
      inboundAt: DateTime.now(),
      outboundAt: DateTime.now(),
      createdAt: DateTime.now());

  group("main functions", () {
    test("add item", () async {
      Services().addItem(bottle);

      expect(itemsBox.keys.contains(bottle.sku), true);
    });
    test("add transaction", () async {
      Services().addTransaction(transaction);
      Services().addTransaction(transaction2);
      expect(transactionBox.keys.length, 2);
    });
    test("get transactions", () async {
      List<Transaction> txns = Services().getTransactions(FilterBy.None, "");
      expect(txns.length, 2);
    });

    test("filter transactions", () async {
      List<Transaction> outBoundTxns =
          Services().getTransactions(FilterBy.Outbound, "");
      List<Transaction> inboundTxns =
          Services().getTransactions(FilterBy.Inbound, "");
      List<Transaction> byQuantity =
          Services().getTransactions(FilterBy.Quantity, "");
      List<Transaction> byDate = Services().getTransactions(FilterBy.Date, "");

      expect(outBoundTxns, [transaction2]);
      expect(inboundTxns, [transaction]);
      expect(byQuantity, [transaction2, transaction]);
      expect(byDate, [transaction2, transaction]);
    });
    test("search transactions", () async {
      List<Transaction> byQuanitity =
          Services().getTransactions(FilterBy.Quantity, "Bottle");

      expect(byQuanitity, [transaction2, transaction]);
    });

    test("delete transactions", () async {
      Services().deleteTransaction(transaction);
      expect(transactionBox.keys.contains(transaction.id), false);
    });

    test("delete item", () async {
      Services().deleteItem(bottle);
      expect(itemsBox.keys.contains(transaction.id), false);
    });
  });
}
