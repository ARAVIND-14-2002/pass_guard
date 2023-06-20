import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypted;
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pass_guard/data/secure_storage/encrypt_data.dart';
import 'package:pass_guard/data/secure_storage/local_secure_storage.dart';
import 'package:pass_guard/domain/models/password_model.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class PasswordManager {
  Future<void> savePassword(
      String nickname, int type, String logo, String password,
      {String? email, String? website}) async {
    final token = await localSecureStorage.readTokenEncrypt();
    final encryptPass = EncryptData.encryptPassword(password, token!);
    final box = Hive.box<PasswordModel>('encrypt-password-fraved');
    final uuid = Uuid();
    final newPass = PasswordModel(
      uid: uuid.v4(),
      nickname: nickname,
      type: type,
      pathLogo: logo,
      password: encryptPass,
      email: email ?? '',
      website: website ?? '',
      isFavorite: false,
      date: DateTime.now(),
    );
    await box.add(newPass);
  }

  Future<void> copyPassword(PasswordModel password) async {
    final token = await localSecureStorage.readTokenEncrypt();
    final iv = encrypted.IV.fromLength(16);
    final encrypter = encrypted.Encrypter(
        encrypted.AES(encrypted.Key.fromUtf8(token!)));
    final decrypted = encrypter.decrypt64(password.password, iv: iv);
    Clipboard.setData(ClipboardData(text: decrypted));
  }

  Future<void> deletePassword(int index) async {
    final box = Hive.box<PasswordModel>('encrypt-password-fraved');
    await box.deleteAt(index);
  }

  Future<void> exportPasswords() async {
    final box = Hive.box<PasswordModel>('encrypt-password-fraved');
    final List<PasswordModel> passwords = box.values.toList();
    final jsonData = jsonEncode(passwords.map((p) => p.toJson()).toList());

    try {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/passwords.hive');

      await file.writeAsString(jsonData);

      print('Passwords exported successfully');
    } catch (e) {
      print('Failed to export passwords: $e');
    }
  }

  Future<void> importPasswords() async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory?.path}/passwords.hive');

    if (await file.exists()) {
      try {
        final jsonData = await file.readAsString();
        final passwordList = jsonDecode(jsonData) as List<dynamic>;

        final box = Hive.box<PasswordModel>('encrypt-password-fraved');
        await box.clear();

        for (final item in passwordList) {
          final password = PasswordModel.fromJson(item as Map<String, dynamic>);
          box.add(password);
        }

        print('Passwords imported successfully');
      } catch (e) {
        print('Failed to import passwords: $e');
      }
    } else {
      print('File not found');
    }
  }




}

