import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

class SecureStorageService {
  static const _keyPrefix = 'secure_';
  static const _encryptionKey = 'my_secret_key_123';

  String _encrypt(String value) {
    List<int> key = utf8.encode(_encryptionKey);
    List<int> bytes = utf8.encode(value);
    List<int> encrypted = List.generate(
      bytes.length,
      (i) => bytes[i] ^ key[i % key.length],
    );
    return base64Encode(encrypted);
  }

  String _decrypt(String encryptedValue) {
    List<int> key = utf8.encode(_encryptionKey);
    List<int> bytes = base64Decode(encryptedValue);
    List<int> decrypted = List.generate(
      bytes.length,
      (i) => bytes[i] ^ key[i % key.length],
    );
    return utf8.decode(decrypted);
  }

  Future<void> setEncrypted(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    String encrypted = _encrypt(value);
    await prefs.setString(_keyPrefix + key, encrypted);
  }

  Future<String?> getDecrypted(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? encrypted = prefs.getString(_keyPrefix + key);
    if (encrypted == null) return null;
    return _decrypt(encrypted);
  }

  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyPrefix + key);
  }
}
