import 'package:sary_project/models/boxes.dart';
import 'package:sary_project/models/repository.dart';
import 'package:sary_project/models/transaction.dart';
import 'package:sary_project/widgets/filter_icon.dart';

class TransactionRepository implements Repository<Transaction> {
  TransactionBox transactionBox;

  TransactionRepository(this.transactionBox);

  @override
  Future<List<Transaction>> getWhere(
      FilterBy filterBy, String searchTerm) async {
    final box = await transactionBox.box;

    List<Transaction> transactions = box.values.toList();

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
        transactions = box.values.toList();
    }
    return transactions
        .where((transaction) => transaction.item.name.contains(searchTerm))
        .toList();
  }

  @override
  Future<void> put(String key, Transaction txn) async {
    final box = await transactionBox.box;
    await box.put(txn.id, txn);
  }

  @override
  Future<void> delete(Transaction txn) async {
    final box = await transactionBox.box;
    await box.delete(txn.id);
  }

  @override
  List<Transaction> getAll(String searchTerm) {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
