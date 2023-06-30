import 'dart:io';
import 'package:pass_guard/presentation/components/text_custom.dart';
import 'package:pass_guard/presentation/screens/about/privacy_policy_screen.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/animation_route.dart';
import '../../../themes/themes.dart';
import '../../about/home_about_screen.dart';
import '../../initial/initial_screen.dart';
import '../../security/home_security_screen.dart';
import 'item_modal_setting.dart';


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

  Future<void> _requestPermissions() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission granted, you can now pick an image.
      _pickImage();
    } else {
      // Permission denied, handle accordingly (show a message, disable functionality, etc.).
      // You can also open the app settings screen to let the user manually grant the required permissions.
      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }
  }

  Future<void> _pickImage() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('profileImage', pickedImage.path);
      }
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Required'),
          content: const Text('Please grant access to the device\'s storage to pick an image.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text('Access to the device\'s storage was denied.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _toggleEditing() async {
    if (_isEditing) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('profileName', _profileNameController.text);
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final profileImage = prefs.getString('profileImage');
    if (profileImage != null) {
      setState(() {
        _image = File(profileImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileName = _isEditing ? _profileNameController.text : 'profileName';

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        final prefs = snapshot.data;
        final storedProfileImage = prefs?.getString('profileImage');

        return Scaffold(
          appBar: AppBar(
            // centerTitle: true,
            title: const TextCustom(
            text: 'Profile',
            color: Colors.white,
            isTitle: true,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _requestPermissions,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          style: BorderStyle.solid,
                          color: Colors.transparent, // Set border color to transparent
                        ),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.pink,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : storedProfileImage != null
                            ? FileImage(File(storedProfileImage))
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _isEditing
                      ? TextFormField(
                    controller: _profileNameController,
                    decoration: InputDecoration(
                      labelText: 'Profile Name',
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: _toggleEditing,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  )
                      : FutureBuilder<SharedPreferences>(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      final prefs = snapshot.data;
                      final storedProfileName =
                          prefs?.getString('profileName') ?? '';

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 50),
                          Center(
                            child: Text(
                              storedProfileName,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            onPressed: _toggleEditing,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 15.0),
                  const SizedBox(height: 15.0),
                  const Text(
                    'General',
                    style: TextStyle(
                      color: ColorsArvi.subtitle,
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
                        // ListTile(
                        //   leading: const Icon(Icons.security),
                        //   title: const Text('Security'),
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       routeFade(page: const HomeSecurityScreen()),
                        //     );
                        //   },
                        // ),
                        // const Divider(
                        //   thickness: 0.2,
                        //   color: Colors.white,
                        // ),
                        ListTile(
                          leading: const Icon(Icons.info),
                          title: const Text('About'),
                          onTap: () {
                            Navigator.push(
                              context,
                              routeFade(page: const HomeAboutScreen()),
                            );
                          },
                        ),
                       const Divider(
                         thickness: 0.2,
                          color: Colors.white,
                      ),
                        ListTile(
                          leading: const Icon(Icons.info),
                          title: const Text('Privacy Policy'),
                          onTap: () {
                            Navigator.push(
                              context,
                              routeFade(page: const PrivacyPolicyScreen()),
                            );
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
                        ItemModalSetting(
                          text: 'App version',
                          icon: FontAwesomeIcons.info,
                          onTap: () {},
                          isVersion: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Theme.of(context).cardTheme.color,
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InitialScreen(),
                        ),
                            (_) => false,
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.red,
                          size: 30,
                        ),
                        SizedBox(width: 5.0),
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

          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: ColorsArvi.primary,
            child: Container(
              decoration: BoxDecoration(
                // gradient: ColorsArvi.bottomAppBarGradient,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [



                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, routeFade(page: HomeScreen()), (route) => false);
                    },
                    icon: const Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, routeFade(page: HomeSecurityScreen()), (route) => false);
                    },
                    icon: const Icon(
                      Icons.security,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => SettingsScreen()),
                      // );
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}