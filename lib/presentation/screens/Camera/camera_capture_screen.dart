import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pass_guard/presentation/components/animation_route.dart';

import 'package:pass_guard/presentation/screens/initial/initial_screen.dart';

import '../../components/text_custom.dart';

class CameraCaptureScreen extends StatefulWidget {
  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      capturePhoto();
    });
  }

  Future<String> getDCIMDirectoryPath() async {
    final directory = await getExternalStorageDirectory();
    return path.join(directory!.path, 'DCIM');
  }

  Future<void> capturePhoto() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    final controller = CameraController(frontCamera, ResolutionPreset.max);
    await controller.initialize();

    final dcimDirectoryPath = await getDCIMDirectoryPath();
    final uniqueFilename = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imagePath = path.join(dcimDirectoryPath, uniqueFilename);

    final XFile? capturedImage = await controller.takePicture();
    if (capturedImage != null) {
      final File imageFile = File(capturedImage.path);

      // Create the destination directory if it doesn't exist
      final destinationDirectory = Directory(dcimDirectoryPath);
      if (!destinationDirectory.existsSync()) {
        destinationDirectory.createSync(recursive: true);
      }

      await imageFile.copy(imagePath);
      print('Image captured: $imagePath');
    }

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          text: 'Forgot Password?',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Alert'),
                  content: Text(
                    'It looks like you have attempted to enter the Master Password incorrectly 3 times now.\nBefore attempting again try recollecting the Master Password.',
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => InitialScreen(),
                          ),
                              (route) => false,
                        );
                      },
                      child: const Text('Go to Home'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Reset Password'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CameraCaptureScreen(),
  ));
}
