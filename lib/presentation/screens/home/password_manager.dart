import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pass_guard/domain/models/password_model.dart';

class PasswordManager {

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
  GlobalKey<ScaffoldMessengerState>();

  Future<void> exportPasswords() async {
    final box = Hive.box<PasswordModel>('encrypt-password-arvi');
    final List<PasswordModel> passwords = box.values.toList();
    final jsonData = jsonEncode(passwords.map((p) => p.toJson()).toList());

    try {
      final directory = await getDownloadsDirectory();
      final file = File('${directory!.path}/passwords.json');
      await file.writeAsString(jsonData);

      print('Passwords exported successfully');
      print('File exported to: ${file.path}');

      _showCustomToast('Passwords exported ');
    } catch (e) {
      print('Failed to export passwords: $e');
    }
  }

  void _showCustomToast(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );

    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }


  Future<void> importPasswords() async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory?.path}/passwords.hive');

    if (await file.exists()) {
      try {
        final jsonData = await file.readAsString();
        final passwordList = jsonDecode(jsonData) as List<dynamic>;

        final box = Hive.box<PasswordModel>('encrypt-password-arvi');
        await box.clear();

        for (final item in passwordList) {
          final password =
          PasswordModel.fromJson(item as Map<String, dynamic>);
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