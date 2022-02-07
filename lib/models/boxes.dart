import 'package:hive_flutter/adapters.dart';
import 'package:sary_project/models/transaction.dart';

import 'item.dart';

class TransactionBox {
  var box = Hive.openBox<Transaction>('transaction');
}

class ItemBox {
  var box = Hive.openBox<Item>('items');
}
