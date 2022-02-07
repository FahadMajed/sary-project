import 'package:sary_project/main.dart';
import 'package:sary_project/models/item.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/widgets/filter_icon.dart';

class Services {
  // static Box<Transaction> getTransactions() => transactionBox;
  // static Box<Item> getItems() => itemsBox;
  List<Transaction> getTransactions(FilterBy filterBy, String searchTerm) {
    List<Transaction> transactions = transactionBox.values.toList();

    switch (filterBy) {
      case FilterBy.Date:
        transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case FilterBy.Quantity:
        transactions.sort((a, b) => b.quantity.compareTo(a.quantity));
        break;
      case FilterBy.Inbound:
        transactions.retainWhere(
            (transaction) => transaction.type == TransactionType.inbound);
        break;
      case FilterBy.Outbound:
        transactions.retainWhere(
            (transaction) => transaction.type == TransactionType.outbound);
        break;
      default:
        transactions = transactionBox.values.toList();
    }

    return transactions
        .where((transaction) => transaction.item.name.contains(searchTerm))
        .toList();
  }

  Future<void> addTransaction(Transaction transaction) async =>
      await transactionBox.put(transaction.id, transaction);

  Future<void> deleteTransaction(Transaction transaction) async =>
      await transactionBox.delete(transaction.id);

  Future<void> addItem(Item item) async => await itemsBox.put(item.sku, item);

  Future<void> deleteItem(Item item) async => await itemsBox.delete(item.sku);
}
