import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/presentation/screens/about/home_about_screen.dart';
import 'package:pass_guard/presentation/screens/home/components/profileprovider.dart';
import 'package:pass_guard/presentation/screens/initial/initial_screen.dart';
import 'package:pass_guard/presentation/screens/security/home_security_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? _image;
  bool _isEditing = false;
  final TextEditingController _profileNameController = TextEditingController();

  @override
  void dispose() {
    _profileNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'profile_image.jpg';
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      setState(() {
        _image = savedImage;
      });
    }
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileName = _isEditing ? _profileNameController.text : "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
              ),
              const SizedBox(height: 16.0),
              _isEditing
                  ? TextFormField(
                controller: _profileNameController,
                decoration: InputDecoration(
                  labelText: 'Profile Name',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: _toggleEditing,
                  ),
                  border: OutlineInputBorder(),
                ),
              )
                  : Row(
                children: [
                  Expanded(
                    child: Text(
                      profileName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: _toggleEditing,
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              const SizedBox(height: 15.0),
              const Text(
                'General',
                style: TextStyle(
                  color: ColorsFrave.subtitle,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text('Security'),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to the security screen
                      },
                    ),
                    const Divider(
                      thickness: 0.2,
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to the about screen
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              const Text(
                'More',
                style: TextStyle(
                  color: Color(0xff6a6570),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('App version'),
                      onTap: () {
                        // Handle app version tap
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Theme.of(context).cardTheme.color,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InitialScreen(),
                    ),
                        (_) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_right,
                      color: Colors.red,
                      size: 20,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      'Log out',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
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

