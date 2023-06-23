import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeAboutScreen extends StatefulWidget {
  const HomeAboutScreen({Key? key}) : super(key: key);

  @override
  _HomeAboutScreenState createState() => _HomeAboutScreenState();
}

class _HomeAboutScreenState extends State<HomeAboutScreen> {
  int tapCount = 0;
  List<String> capturedImages = [];
  late String imageDirectoryPath;

  @override
  void initState() {
    super.initState();
    _getImageDirectoryPath();
  }

  void _getImageDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    imageDirectoryPath = directory.path;
  }

  void _handleImageTap() {
    setState(() {
      tapCount++;
      if (tapCount == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnotherPage(
              capturedImages: capturedImages,
              imageDirectory: imageDirectoryPath,
            ),
          ),
        ).then((value) {
          // Reset tap count when returning from another page
          tapCount = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    // Reset tap count when the screen is disposed
    tapCount = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'About',
          color: Colors.grey,
          isTitle: true,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _handleImageTap,
              child: Image.asset('assets/img/logo-white.png', height: 200),
            ),
            const SizedBox(height: 30.0),
            const TextCustom(
              text: 'PASS GUARD',
              isTitle: true,
              fontWeight: FontWeight.bold,
              fontSize: 32,
              textAlign: TextAlign.center,
              color: Colors.white,
            ),
            const SizedBox(height: 10.0),
            const TextCustom(
              text: 'V 1.0.0',
              color: Colors.grey,
              isTitle: true,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  final List<String> capturedImages;
  final String imageDirectory;

  const AnotherPage({
    required this.capturedImages,
    required this.imageDirectory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Why are you Here?'),
      ),
      body: ListView.builder(
        itemCount: capturedImages.length,
        itemBuilder: (context, index) {
          final imagePath = capturedImages[index];
          final imageFile = File('$imageDirectory/$imagePath');

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(imageFile),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeAboutScreen(),
  ));
}