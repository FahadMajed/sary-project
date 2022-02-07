import 'package:hive_flutter/hive_flutter.dart';
import 'package:sary_project/widgets/filter_icon.dart';

abstract class Repository<T extends HiveObject> {
  Future<void> put(String key, T newObject);

  Future<void> delete(T objectToDelete);

  List<T> getAll(String searchTerm);

  Future<List<T>> getWhere(FilterBy filterBy, String searchTerm);
}
