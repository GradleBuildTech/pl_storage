///[DbStrategy] Database Strategy
///
/// This class is used to abstract the database operations
/// It is used to abstract the database operations
/// It is used to abstract the database operations
///
/// Example:
/// ```dart
/// class MyDbStrategy extends DbStrategy {
///   @override
///   String get dbName => 'my_db';
/// }
/// ```
abstract class DbStrategy {
  /// The name of the database
  String get dbName;

  /// The key of the database
  dynamic get key;

  /// The list of tables name
  Future<List<String>> getListTablesName();

  /// The list of data
  ///
  /// [tableName] The name of the table
  /// [where] The where clause
  /// [columns] The columns to select
  /// [orderBy] The order by clause
  /// [limit] The limit
  /// [offset] The offset
  Future<List<Map<String, dynamic>>> getListData(
    String tableName, {
    String? where,
    List<String>? columns,
    String? orderBy,
    int? limit,
    int? offset,
  });

  /// The list of data
  ///
  /// [tableName] The name of the table
  /// [data] The data to insert
  Future<void> insertData(String tableName, Map<String, dynamic> data);

  /// The data to update
  ///
  /// [tableName] The name of the table
  /// [data] The data to update
  Future<void> updateData(String tableName, Map<String, dynamic> data);

  /// The key of the data to delete
  ///
  /// [tableName] The name of the table
  /// [key] The key of the data to delete
  Future<void> deleteData(String tableName, dynamic key);

  /// The name of the table to delete all data
  ///
  /// [tableName] The name of the table to delete all data
  Future<void> deleteAllData(String tableName);

  /// The close of the database
  ///
  /// [tableName] The name of the table to close
  Future<void> close();

  /// The writeable of the database
  ///
  /// [tableName] The name of the table to writeable
  bool get spWriteable;

  /// The paginable of the database
  ///
  /// [tableName] The name of the table to paginable
  bool get spPaginable;

  /// The dispose of the database
  ///
  /// [tableName] The name of the table to dispose
  Future<void> dispose();
}
