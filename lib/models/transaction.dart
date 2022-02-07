import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/models/item.dart';

part 'transaction.g.dart';

@HiveType(typeId: 4)
class Transaction extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final TransactionType type;
  @HiveField(2)
  final Item item;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final DateTime inboundAt;
  @HiveField(5)
  final DateTime outboundAt;
  @HiveField(6)
  final DateTime createdAt;

  Transaction(
      {required this.id,
      required this.type,
      required this.item,
      required this.quantity,
      required this.inboundAt,
      required this.outboundAt,
      required this.createdAt});
}

@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  inbound,
  @HiveField(1)
  outbound
}
