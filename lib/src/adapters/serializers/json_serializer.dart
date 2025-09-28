import 'dart:convert';

/// JSON serializer for storage adapters
///
/// Handles serialization and deserialization of data to/from JSON format.
/// Provides error handling and validation for JSON operations.
class JsonSerializer {
  /// Serialize data to JSON string
  ///
  /// [data] - The data to serialize
  /// Returns JSON string representation
  /// Throws [JsonUnsupportedObjectError] if data contains unsupported types
  String serialize(Map<String, dynamic> data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      throw JsonUnsupportedObjectError('Failed to serialize data: $e');
    }
  }

  /// Deserialize JSON string to data
  ///
  /// [jsonString] - The JSON string to deserialize
  /// Returns Map representation of the data
  /// Throws [FormatException] if JSON is invalid
  Map<String, dynamic> deserialize(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        throw FormatException(
          'Expected JSON object, got ${decoded.runtimeType}',
        );
      }
    } catch (e) {
      throw FormatException('Invalid JSON: $e');
    }
  }

  /// Serialize list of data to JSON string
  String serializeList(List<Map<String, dynamic>> dataList) {
    try {
      return jsonEncode(dataList);
    } catch (e) {
      throw JsonUnsupportedObjectError('Failed to serialize list: $e');
    }
  }

  /// Deserialize JSON string to list of data
  List<Map<String, dynamic>> deserializeList(String jsonString) {
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      } else {
        throw FormatException(
          'Expected JSON array, got ${decoded.runtimeType}',
        );
      }
    } catch (e) {
      throw FormatException('Invalid JSON array: $e');
    }
  }

  /// Pretty print JSON string
  String prettyPrint(Map<String, dynamic> data) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }

  /// Check if string is valid JSON
  bool isValidJson(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get JSON size in bytes
  int getJsonSize(Map<String, dynamic> data) {
    return serialize(data).codeUnits.length;
  }
}

/// Custom error for JSON serialization issues
class JsonUnsupportedObjectError extends Error {
  final String message;

  JsonUnsupportedObjectError(this.message);

  @override
  String toString() => 'JsonUnsupportedObjectError: $message';
}
