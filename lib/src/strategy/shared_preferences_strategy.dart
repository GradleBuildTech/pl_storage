import '../core/database_strategy.dart';

class SharedPreferencesStrategy extends DbStrategy {
  final String _dbName;

  final dynamic _db;

  SharedPreferencesStrategy(this._dbName, this._db);

  @override
  Future<void> close() {
    throw UnimplementedError();
  }

  @override
  String get dbName => _dbName;

  @override
  Future<void> deleteAllData(String tableName) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteData(String tableName, key) {
    throw UnimplementedError();
  }

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> getListData(
    String tableName, {
    String? where,
    List<String>? columns,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getListTablesName() {
    throw UnimplementedError();
  }

  @override
  Future<void> insertData(String tableName, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  get key => throw UnimplementedError();

  @override
  bool get spPaginable => throw UnimplementedError();

  @override
  bool get spWriteable => throw UnimplementedError();

  @override
  Future<void> updateData(String tableName, Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}
