import 'dart:convert';
import 'package:flutter/foundation.dart';

// Simple in-memory storage for web/demo purposes
// In a real app, you would use SharedPreferences, Hive, or other storage solutions
class StorageService {
  static final Map<String, dynamic> _storage = {};

  // String operations
  static Future<void> setString(String key, String value) async {
    try {
      _storage[key] = value;
      debugPrint('Stored string for key: $key');
    } catch (e) {
      debugPrint('Error storing string for key $key: $e');
      rethrow;
    }
  }

  static Future<String?> getString(String key) async {
    try {
      final value = _storage[key] as String?;
      debugPrint('Retrieved string for key: $key, value exists: ${value != null}');
      return value;
    } catch (e) {
      debugPrint('Error retrieving string for key $key: $e');
      return null;
    }
  }

  // Boolean operations
  static Future<void> setBool(String key, bool value) async {
    try {
      _storage[key] = value;
      debugPrint('Stored bool for key: $key, value: $value');
    } catch (e) {
      debugPrint('Error storing bool for key $key: $e');
      rethrow;
    }
  }

  static Future<bool?> getBool(String key) async {
    try {
      final value = _storage[key] as bool?;
      debugPrint('Retrieved bool for key: $key, value: $value');
      return value;
    } catch (e) {
      debugPrint('Error retrieving bool for key $key: $e');
      return null;
    }
  }

  // Integer operations
  static Future<void> setInt(String key, int value) async {
    try {
      _storage[key] = value;
      debugPrint('Stored int for key: $key, value: $value');
    } catch (e) {
      debugPrint('Error storing int for key $key: $e');
      rethrow;
    }
  }

  static Future<int?> getInt(String key) async {
    try {
      final value = _storage[key] as int?;
      debugPrint('Retrieved int for key: $key, value: $value');
      return value;
    } catch (e) {
      debugPrint('Error retrieving int for key $key: $e');
      return null;
    }
  }

  // Double operations
  static Future<void> setDouble(String key, double value) async {
    try {
      _storage[key] = value;
      debugPrint('Stored double for key: $key, value: $value');
    } catch (e) {
      debugPrint('Error storing double for key $key: $e');
      rethrow;
    }
  }

  static Future<double?> getDouble(String key) async {
    try {
      final value = _storage[key] as double?;
      debugPrint('Retrieved double for key: $key, value: $value');
      return value;
    } catch (e) {
      debugPrint('Error retrieving double for key $key: $e');
      return null;
    }
  }

  // List operations
  static Future<void> setStringList(String key, List<String> value) async {
    try {
      _storage[key] = value;
      debugPrint('Stored string list for key: $key, length: ${value.length}');
    } catch (e) {
      debugPrint('Error storing string list for key $key: $e');
      rethrow;
    }
  }

  static Future<List<String>?> getStringList(String key) async {
    try {
      final value = _storage[key] as List<String>?;
      debugPrint('Retrieved string list for key: $key, length: ${value?.length}');
      return value;
    } catch (e) {
      debugPrint('Error retrieving string list for key $key: $e');
      return null;
    }
  }

  // JSON operations
  static Future<void> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      await setString(key, jsonString);
      debugPrint('Stored JSON for key: $key');
    } catch (e) {
      debugPrint('Error storing JSON for key $key: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getJson(String key) async {
    try {
      final jsonString = await getString(key);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        debugPrint('Retrieved JSON for key: $key');
        return json;
      }
      return null;
    } catch (e) {
      debugPrint('Error retrieving JSON for key $key: $e');
      return null;
    }
  }

  // Remove operations
  static Future<void> remove(String key) async {
    try {
      _storage.remove(key);
      debugPrint('Removed key: $key');
    } catch (e) {
      debugPrint('Error removing key $key: $e');
      rethrow;
    }
  }

  static Future<void> clear() async {
    try {
      _storage.clear();
      debugPrint('Cleared all storage');
    } catch (e) {
      debugPrint('Error clearing storage: $e');
      rethrow;
    }
  }

  // Check if key exists
  static Future<bool> containsKey(String key) async {
    try {
      final exists = _storage.containsKey(key);
      debugPrint('Key $key exists: $exists');
      return exists;
    } catch (e) {
      debugPrint('Error checking key $key: $e');
      return false;
    }
  }

  // Get all keys
  static Future<Set<String>> getKeys() async {
    try {
      final keys = _storage.keys.toSet();
      debugPrint('Retrieved ${keys.length} keys');
      return keys;
    } catch (e) {
      debugPrint('Error getting keys: $e');
      return <String>{};
    }
  }

  // Batch operations
  static Future<void> setBatch(Map<String, dynamic> data) async {
    try {
      for (final entry in data.entries) {
        _storage[entry.key] = entry.value;
      }
      debugPrint('Stored batch of ${data.length} items');
    } catch (e) {
      debugPrint('Error storing batch: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getBatch(List<String> keys) async {
    try {
      final result = <String, dynamic>{};
      for (final key in keys) {
        if (_storage.containsKey(key)) {
          result[key] = _storage[key];
        }
      }
      debugPrint('Retrieved batch of ${result.length} items');
      return result;
    } catch (e) {
      debugPrint('Error retrieving batch: $e');
      return <String, dynamic>{};
    }
  }

  // Storage info
  static Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final info = {
        'totalKeys': _storage.length,
        'keys': _storage.keys.toList(),
        'estimatedSize': _calculateSize(),
      };
      debugPrint('Storage info: $info');
      return info;
    } catch (e) {
      debugPrint('Error getting storage info: $e');
      return <String, dynamic>{};
    }
  }

  static int _calculateSize() {
    try {
      int totalSize = 0;
      for (final entry in _storage.entries) {
        totalSize += entry.key.length;
        if (entry.value is String) {
          totalSize += (entry.value as String).length;
        } else {
          totalSize += entry.value.toString().length;
        }
      }
      return totalSize;
    } catch (e) {
      debugPrint('Error calculating storage size: $e');
      return 0;
    }
  }
}