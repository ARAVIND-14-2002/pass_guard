import 'dart:io';

import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _profileName = 'John Doe';
  File? _profileImage;

  String get profileName => _profileName;
  File? get profileImage => _profileImage;

  void setProfileName(String name) {
    _profileName = name;
    notifyListeners();
  }

  void setProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }
}

