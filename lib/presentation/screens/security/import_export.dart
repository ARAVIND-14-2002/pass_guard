import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:pass_guard/domain/models/password_model.dart';

class LocalFileDirectory extends StatelessWidget {
  final Function(File file) onFilePicked;

  const LocalFileDirectory({super.key, required this.onFilePicked});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local File Directory'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final FilePickerResult? result =
            await FilePicker.platform.pickFiles();
            if (result != null && result.files.isNotEmpty) {
              final File file = File(result.files.first.path!);
              onFilePicked(file);
            }
          },
          child: const Text('Open File Directory'),
        ),
      ),
    );
  }
}

class PasswordManager {
  Future<void> importPasswords(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      try {
        final jsonData = await file.readAsString();
        final passwordList = jsonDecode(jsonData) as List<dynamic>;

        final box = await Hive.openBox<PasswordModel>('encrypt-password-fraved');
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

class ImportExport extends StatelessWidget {
  final PasswordManager passwordManager = PasswordManager();

  ImportExport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PassGuard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Export passwords
                exportPasswords();
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/export.png'),
              ),
            ),
            const SizedBox(height: 150),
            GestureDetector(
              onTap: () {
                // Navigate to LocalFileDirectory to import passwords
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LocalFileDirectory(
                    onFilePicked: (File file) {
                      passwordManager.importPasswords(file.path);
                    },
                  )),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset('assets/import.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> exportPasswords() async {
    final box = Hive.box<PasswordModel>('encrypt-password-fraved');
    final List<PasswordModel> passwords = box.values.toList();
    final jsonData = jsonEncode(passwords.map((p) => p.toJson()).toList());

    try {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/passwords.json');

      await file.writeAsString(jsonData);

      print('Passwords exported successfully');
    } catch (e) {
      print('Failed to export passwords: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(PasswordModelAdapter());
  await Hive.openBox<PasswordModel>('encrypt-password-fraved');

  runApp(MaterialApp(
    title: 'Image App',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ImportExport(),
  ));
}
