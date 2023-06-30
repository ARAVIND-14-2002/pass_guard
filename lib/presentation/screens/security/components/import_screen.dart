import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class LocalFileDirectory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local File Directory'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            openLocalFileDirectory(context);
          },
          child: Text('Open File Directory'),
        ),
      ),
    );
  }
}

Future<void> openLocalFileDirectory(BuildContext context) async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null && result.files.isNotEmpty) {
    final String filePath = result.files.first.path ?? '';
    final String fileName = result.files.first.name ?? '';

    final appDir = await getApplicationDocumentsDirectory();
    final hiveBox = await Hive.openBox('myBox'); // Open your Hive box here

    try {
      final file = File('$filePath/$fileName');
      final encryptedData = await file.readAsString();

      // Decrypt the encrypted data
      final key = encrypt.Key.fromUtf8('encrypt-password-arvi');
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final decryptedData = encrypter.decrypt64(encryptedData, iv: iv);

      final jsonData = jsonDecode(decryptedData) as List<dynamic>;

      // Clear existing box data before importing
      await hiveBox.clear();

      for (final item in jsonData) {
        hiveBox.add(item);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File imported successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing file')),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Local File Directory',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: LocalFileDirectory(),
  ));
}
