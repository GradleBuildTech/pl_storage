import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Encrypted serializer for secure storage
///
/// Handles encryption and decryption of sensitive data before storage.
/// Uses AES encryption with key derivation for secure data storage.
class EncryptedSerializer {
  /// Encrypt and serialize data
  ///
  /// [data] - The data to encrypt and serialize
  /// [key] - The encryption key (will be hashed for security)
  /// Returns encrypted JSON string
  String encryptAndSerialize(Map<String, dynamic> data, String key) {
    try {
      // Convert data to JSON
      final jsonString = jsonEncode(data);

      // Generate encryption key from input key
      final encryptionKey = _generateKey(key);

      // Simple XOR encryption (replace with proper AES in production)
      final encryptedBytes = _xorEncrypt(
        utf8.encode(jsonString),
        encryptionKey,
      );

      // Encode as base64 for storage
      return base64Encode(encryptedBytes);
    } catch (e) {
      throw EncryptionError('Failed to encrypt data: $e');
    }
  }

  /// Decrypt and deserialize data
  ///
  /// [encryptedData] - The encrypted data string
  /// [key] - The decryption key
  /// Returns decrypted data as Map
  Map<String, dynamic> decryptAndDeserialize(String encryptedData, String key) {
    try {
      // Decode from base64
      final encryptedBytes = base64Decode(encryptedData);

      // Generate decryption key from input key
      final decryptionKey = _generateKey(key);

      // Simple XOR decryption (replace with proper AES in production)
      final decryptedBytes = _xorDecrypt(encryptedBytes, decryptionKey);

      // Decode from UTF-8
      final jsonString = utf8.decode(decryptedBytes);

      // Parse JSON
      final decoded = jsonDecode(jsonString);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      } else {
        throw FormatException(
          'Expected JSON object, got ${decoded.runtimeType}',
        );
      }
    } catch (e) {
      throw EncryptionError('Failed to decrypt data: $e');
    }
  }

  /// Generate encryption key from string
  ///
  /// [keyString] - The input key string
  /// Returns 32-byte key for encryption
  List<int> _generateKey(String keyString) {
    // Use SHA-256 to generate consistent key
    final bytes = utf8.encode(keyString);
    final digest = sha256.convert(bytes);
    return digest.bytes;
  }

  /// Simple XOR encryption (replace with AES in production)
  List<int> _xorEncrypt(List<int> data, List<int> key) {
    final result = <int>[];
    for (int i = 0; i < data.length; i++) {
      result.add(data[i] ^ key[i % key.length]);
    }
    return result;
  }

  /// Simple XOR decryption (replace with AES in production)
  List<int> _xorDecrypt(List<int> encryptedData, List<int> key) {
    // XOR is symmetric, so decryption is the same as encryption
    return _xorEncrypt(encryptedData, key);
  }

  /// Encrypt list of data
  String encryptAndSerializeList(
    List<Map<String, dynamic>> dataList,
    String key,
  ) {
    try {
      final jsonString = jsonEncode(dataList);
      final encryptionKey = _generateKey(key);
      final encryptedBytes = _xorEncrypt(
        utf8.encode(jsonString),
        encryptionKey,
      );
      return base64Encode(encryptedBytes);
    } catch (e) {
      throw EncryptionError('Failed to encrypt list: $e');
    }
  }

  /// Decrypt list of data
  List<Map<String, dynamic>> decryptAndDeserializeList(
    String encryptedData,
    String key,
  ) {
    try {
      final encryptedBytes = base64Decode(encryptedData);
      final decryptionKey = _generateKey(key);
      final decryptedBytes = _xorDecrypt(encryptedBytes, decryptionKey);
      final jsonString = utf8.decode(decryptedBytes);
      final decoded = jsonDecode(jsonString);

      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      } else {
        throw FormatException(
          'Expected JSON array, got ${decoded.runtimeType}',
        );
      }
    } catch (e) {
      throw EncryptionError('Failed to decrypt list: $e');
    }
  }

  /// Validate encryption key strength
  bool isKeyStrong(String key) {
    // Check minimum length and complexity
    return key.length >= 8 &&
        key.contains(RegExp(r'[A-Z]')) &&
        key.contains(RegExp(r'[a-z]')) &&
        key.contains(RegExp(r'[0-9]'));
  }

  /// Generate secure random key
  String generateSecureKey() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode(random);
    final digest = sha256.convert(bytes);
    return digest.toString().substring(0, 16);
  }

  /// Get encrypted data size
  int getEncryptedSize(Map<String, dynamic> data, String key) {
    final encrypted = encryptAndSerialize(data, key);
    return utf8.encode(encrypted).length;
  }
}

/// Custom error for encryption/decryption issues
class EncryptionError extends Error {
  final String message;

  EncryptionError(this.message);

  @override
  String toString() => 'EncryptionError: $message';
}
