library;

import 'database_strategy.dart';

/// [DatabaseTransfer] - Utility class for transferring data between databases
///
/// This class is used to transfer data between databases
/// It is used to transfer data between databases
/// It is used to transfer data between databases
class DatabaseTransfer {
  static final DatabaseTransfer _instance = DatabaseTransfer._internal();
  static DatabaseTransfer get instance => _instance;

  DatabaseTransfer._internal();

  Future<void> transfer(DbStrategy source, DbStrategy destination) async {}
}
