// Helper class for the storage plugin

class Helper {
  // Get the type of the value
  static String getType(dynamic value) {
    if (value is bool) return 'bool';
    if (value is int) return 'int';
    if (value is double) return 'double';
    if (value is String) return 'string';
    if (value is List<dynamic>) return 'list';
    if (value is Map<String, dynamic>) return 'map';
    return 'unknown';
  }
}
