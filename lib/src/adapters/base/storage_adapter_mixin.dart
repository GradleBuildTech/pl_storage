import 'package:flutter/foundation.dart';
import '../serializers/json_serializer.dart';
import '../serializers/encrypted_serializer.dart';

/// Mixin providing common storage adapter functionality
///
/// This mixin provides utilities for:
/// - Data serialization/deserialization
/// - Error handling and logging
/// - Performance monitoring
/// - Data validation and sanitization
mixin StorageAdapterMixin {
  /// JSON serializer instance
  final JsonSerializer _jsonSerializer = JsonSerializer();

  /// Encrypted serializer instance
  final EncryptedSerializer _encryptedSerializer = EncryptedSerializer();

  /// Serialize data to JSON string
  String serializeToJson(Map<String, dynamic> data) {
    try {
      return _jsonSerializer.serialize(data);
    } catch (e) {
      debugPrint('JSON serialization error: $e');
      rethrow;
    }
  }

  /// Deserialize JSON string to data
  Map<String, dynamic> deserializeFromJson(String jsonString) {
    try {
      return _jsonSerializer.deserialize(jsonString);
    } catch (e) {
      debugPrint('JSON deserialization error: $e');
      rethrow;
    }
  }

  /// Encrypt and serialize data
  String encryptAndSerialize(Map<String, dynamic> data, String key) {
    try {
      return _encryptedSerializer.encryptAndSerialize(data, key);
    } catch (e) {
      debugPrint('Encryption error: $e');
      rethrow;
    }
  }

  /// Decrypt and deserialize data
  Map<String, dynamic> decryptAndDeserialize(String encryptedData, String key) {
    try {
      return _encryptedSerializer.decryptAndDeserialize(encryptedData, key);
    } catch (e) {
      debugPrint('Decryption error: $e');
      rethrow;
    }
  }

  /// Validate data structure
  bool validateDataStructure(
    Map<String, dynamic> data,
    List<String> requiredFields,
  ) {
    for (final field in requiredFields) {
      if (!data.containsKey(field)) {
        debugPrint('Missing required field: $field');
        return false;
      }
    }
    return true;
  }

  /// Sanitize data by removing null values and trimming strings
  Map<String, dynamic> sanitizeData(Map<String, dynamic> data) {
    final sanitized = <String, dynamic>{};

    for (final entry in data.entries) {
      if (entry.value != null) {
        if (entry.value is String) {
          final trimmed = (entry.value as String).trim();
          if (trimmed.isNotEmpty) {
            sanitized[entry.key] = trimmed;
          }
        } else {
          sanitized[entry.key] = entry.value;
        }
      }
    }

    return sanitized;
  }

  /// Log performance metrics
  void logPerformance(String operation, Duration duration) {
    if (kDebugMode) {
      debugPrint(
        'Storage operation "$operation" took ${duration.inMilliseconds}ms',
      );
    }
  }

  /// Handle storage errors with proper logging
  void handleStorageError(String operation, dynamic error) {
    debugPrint('Storage error in $operation: $error');
    // Could add crash reporting here
  }

  /// Check if data is valid JSON
  bool isValidJson(String jsonString) {
    try {
      _jsonSerializer.deserialize(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get data size in bytes
  int getDataSize(Map<String, dynamic> data) {
    final jsonString = serializeToJson(data);
    return jsonString.codeUnits.length;
  }

  /// Compress data if it exceeds threshold
  Map<String, dynamic> compressIfNeeded(
    Map<String, dynamic> data,
    int thresholdBytes,
  ) {
    final size = getDataSize(data);
    if (size > thresholdBytes) {
      // Implement compression logic here
      debugPrint(
        'Data size $size bytes exceeds threshold $thresholdBytes bytes',
      );
    }
    return data;
  }
}
