import 'dart:convert';

import 'package:pl_storage/src/utils/logger.dart';

import '../core/database_strategy.dart';
import '../utils/helper.dart';

class SharedPreferencesStrategy extends DbStrategy {
  final String _dbName;

  final dynamic _preferences;

  SharedPreferencesStrategy(this._preferences, {String? dbName})
    : _dbName = dbName ?? 'shared_preferences';

  @override
  String get dbName => _dbName;

  @override
  Future<void> close() {
    return Future.value();
  }

  @override
  Future<void> deleteAllData(String tableName) async {
    await _preferences.clear();
  }

  // Remove key from shared preferences
  Future<void> _removeKey(dynamic key) async {
    try {
      await _preferences.remove(key);
    } catch (e) {
      Logger.d('Error removing key $key', e.toString());
      rethrow;
    }
  }

  // Remove key from shared preferences
  @override
  Future<void> deleteData(String tableName, dynamic key) async {
    try {
      var removeKey = "";

      // If key is a map, get the key from the map
      if (key is Map<String, dynamic> && key.containsKey('key')) {
        removeKey = key['key'] as String;
      } else {
        removeKey = key.toString();
      }
      await _removeKey(removeKey);
    } catch (e) {
      Logger.d('Error removing key $key', e.toString());
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    await _preferences.clear();
  }

  @override
  Future<List<Map<String, dynamic>>> getListData(
    String tableName, {
    String? where,
    List<String>? columns,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      final List<Map<String, dynamic>> listData = [];
      final Set<String> keys = _getKeys();
      var startIndex = offset ?? 0;
      var endIndex = limit != null ? startIndex + limit : keys.length;

      if (endIndex > keys.length) {
        endIndex = keys.length;
      }

      if (startIndex >= keys.length) {
        return [];
      }

      final selectedKeys = keys
          .skip(startIndex)
          .take(endIndex - startIndex)
          .toList();

      for (final key in selectedKeys) {
        final value = _preferences.get(key);
        final type = Helper.getType(_preferences.get(key));
      }

      return listData;
    } catch (e) {
      Logger.d('Error getting list data', e.toString());
      rethrow;
    }
  }

  @override
  Future<List<String>> getListTablesName() {
    return Future.value([_dbName]);
  }

  @override
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    try {
      // If key is a map, get the key from the map
      final key = data['key'];
      // If value is a map, get the value from the map

      final value = data['value'];

      // Get the type of the value
      final type = Helper.getType(value);
      await _set(key, value, type);
    } catch (e) {
      Logger.d('Error inserting data $data', e.toString());
      rethrow;
    }
  }

  @override
  get key => throw UnimplementedError();

  @override
  bool get spPaginable => throw UnimplementedError();

  @override
  bool get spWriteable => throw UnimplementedError();

  @override
  Future<void> updateData(String tableName, Map<String, dynamic> data) async {
    try {
      final key = data['key'];
      final value = data['value'];
      final type = Helper.getType(value);
      await _set(key, value, type);
    } catch (e) {
      Logger.d('Error updating data $data', e.toString());
      rethrow;
    }
  }

  Set<String> _getKeys() {
    try {
      return _preferences.getKeys();
    } catch (e) {
      Logger.d('Error getting keys', e.toString());
      return {};
    }
  }

  // Set value to shared preferences
  // @param key: key to set value
  // @param value: value to set
  // @param type: type of the value
  // @return void
  Future<void> _set(String key, dynamic value, String type) async {
    try {
      switch (type) {
        case 'bool':
          await _preferences.setBool(key, value);
          break;
        case 'int':
          await _preferences.setInt(key, value);
          break;
        case 'double':
          await _preferences.setDouble(key, value);
          break;
        case 'string':
          await _preferences.setString(key, value);
          break;
        case 'list':
          await _preferences.setStringList(key, value);
          break;
        case 'map':
          await _preferences.setString(key, jsonEncode(value));
          break;
        default:
          if (value is String) {
            await _preferences.setString(key, value);
          } else if (value is int) {
            await _preferences.setInt(key, value);
          } else if (value is double) {
            await _preferences.setDouble(key, value);
          } else if (value is bool) {
            await _preferences.setBool(key, value);
          } else {
            throw Exception('Invalid type: $type');
          }
          break;
      }
    } catch (e) {
      Logger.d('Error setting value $value with type $type', e.toString());
      rethrow;
    }
  }
}
