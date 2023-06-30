import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:path_provider/path_provider.dart';

import 'package:file_picker/file_picker.dart';

import 'package:hive/hive.dart';
import 'package:pass_guard/domain/models/password_model.dart';

class LocalFileDirectory extends StatelessWidget {
  final Function(File file) onFilePicked;

  const LocalFileDirectory({Key? key, required this.onFilePicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local File Directory'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final FilePickerResult? result = await FilePicker.platform.pickFiles();
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
  Future<void> importPasswords(String filePath, BuildContext context) async {
    final file = File(filePath);

    if (await file.exists()) {
      try {
        final jsonData = await file.readAsString();
        final passwordList = jsonDecode(jsonData) as List<dynamic>;

        final box = await Hive.openBox<PasswordModel>('encrypt-password-arvi');

        for (final item in passwordList) {
          final password = PasswordModel.fromJson(item as Map<String, dynamic>);
          box.add(password);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords imported successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to import passwords'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File does not exist'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class ImportExport extends StatefulWidget {
  @override
  _ImportExportState createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  final passwordManager = PasswordManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Back Up'),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Handle import logic
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LocalFileDirectory(
                              onFilePicked: (File file) {
                                passwordManager.importPasswords(file.path, context);
                              },
                            ),
                          ),
                        );
                      },
                      child: const BoxWithIcon(
                        icon: Icons.file_upload,
                        text: 'Import',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Handle export logic
                        exportPasswords(context);
                      },
                      child: const BoxWithIcon(
                        icon: Icons.file_download,
                        text: 'Export',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 24.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded1 = !isExpanded1;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Export Settings',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          isExpanded1 ? Icons.expand_less : Icons.expand_more,
                          size: 24.0,
                        ),
                      ],
                    ),
                    if (isExpanded1) ...[
                      const SizedBox(height: 20.0),
                      const TransparentGlassBox(
                        text: 'Exported File is stored safely in the directory \nAndroid/data/com.arvi.pass_guard/files',
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded2 = !isExpanded2;
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Import Settings',
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          isExpanded2 ? Icons.expand_less : Icons.expand_more,
                          size: 24.0,
                        ),
                      ],
                    ),
                    if (isExpanded2) ...[
                      const SizedBox(height: 16.0),
                      const TransparentGlassBox(
                        text: 'You can use Import and Export(json) feature to\ntransfer Passwords between two devices.',
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const BoxWithIcon({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsArvi.primary,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48.0,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TransparentGlassBox extends StatelessWidget {
  final String text;

  const TransparentGlassBox({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(PasswordModelAdapter());
  await Hive.openBox<PasswordModel>('encrypt-password-arvi');

  runApp(MaterialApp(
    title: 'Image App',
    theme: ThemeData(primarySwatch: Colors.purple),
    home: ImportExport(),
  ));
}

Future<void> exportPasswords(BuildContext context) async {
  final box = Hive.box<PasswordModel>('encrypt-password-arvi');
  final List<PasswordModel> passwords = box.values.toList();
  final jsonData = jsonEncode(passwords.map((p) => p.toJson()).toList());

  try {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/passwords.json');

    await file.writeAsString(jsonData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passwords exported successfully'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to export passwords'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
