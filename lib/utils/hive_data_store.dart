import 'package:hive_flutter/hive_flutter.dart';
import '../views/entry.dart';

class HiveDataStore {
  final boxRecords = Hive.box('records');

  Future<void> addRecord({required Record record}) async {
    await boxRecords.put(record.id, record);
  }

  Future<Record?> getRecord({required String id}) async {
    return boxRecords.get(id);
  }

  Future<void> updateRecord({required Record record}) async {
    await boxRecords.put(record.id, record);
  }

  Future<void> deleteRecord({required Record record}) async {
    await boxRecords.delete(record.id);
  }
}
