import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uchochik/data/models/concentrator_model.dart';
import 'package:uchochik/data/models/meter_model.dart';
import 'package:uchochik/data/models/network_group_model.dart';
import 'package:uchochik/data/models/operation_log_model.dart';

// Isar 3.x stable does not expose DB-level encryption in its open() API.
// We apply AES-256-CBC field-level encryption to all sensitive meter fields
// (password, encryptionKey, authenticationKey) before they touch the DB.
// The AES key lives in the Android Keystore-backed secure storage.

const _keyStoreKey = 'field_encryption_key_v1';

/// Singleton — call [init] once at app startup before any DB access.
class IsarService {
  IsarService._();
  static final instance = IsarService._();

  late Isar _isar;
  late enc.Encrypter _encrypter;
  Isar get isar => _isar;

  Future<void> init() async {
    final keyBytes = await _resolveFieldEncryptionKey();
    _encrypter = enc.Encrypter(
      enc.AES(enc.Key(Uint8List.fromList(keyBytes)), mode: enc.AESMode.cbc),
    );

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        NetworkGroupModelSchema,
        ConcentratorModelSchema,
        MeterModelSchema,
        OperationLogModelSchema,
      ],
      directory: dir.path,
      name: 'uchochik_db',
    );
  }

  /// Encrypts a plaintext string. Returns base64(iv + ciphertext).
  String encrypt(String plaintext) {
    final iv = enc.IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(plaintext, iv: iv);
    final combined = iv.bytes + encrypted.bytes;
    return base64Encode(combined);
  }

  /// Decrypts a value produced by [encrypt].
  String decrypt(String ciphertext) {
    final combined = base64Decode(ciphertext);
    final iv = enc.IV(Uint8List.fromList(combined.sublist(0, 16)));
    final data = enc.Encrypted(Uint8List.fromList(combined.sublist(16)));
    return _encrypter.decrypt(data, iv: iv);
  }

  /// Reads AES-256 key from Android Keystore-backed secure storage.
  /// Generates and persists a random 32-byte key on first launch.
  Future<List<int>> _resolveFieldEncryptionKey() async {
    const storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    String? stored = await storage.read(key: _keyStoreKey);
    if (stored == null) {
      final key = List<int>.generate(32, (_) => Random.secure().nextInt(256));
      stored = base64Encode(key);
      await storage.write(key: _keyStoreKey, value: stored);
    }
    return base64Decode(stored);
  }

  Future<void> close() => _isar.close();
}
