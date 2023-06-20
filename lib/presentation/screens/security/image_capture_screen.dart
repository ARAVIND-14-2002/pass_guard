import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  File? _pickedImage;

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front, // Limit camera access to the front camera
    );

    if (pickedImage != null) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
    } else {
      // Image capture canceled or failed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Capture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_pickedImage != null)
              Image.file(
                _pickedImage!,
                height: 200,
              ),
            ElevatedButton(
              onPressed: _captureImage,
              child: Text('Capture Image'),
            ),
          ],
        ),
      ),
    );
  }
}
