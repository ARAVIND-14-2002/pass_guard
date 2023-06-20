import 'package:flutter/material.dart';

class ImportExport extends StatelessWidget {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ImageScreen()),
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
            const SizedBox(height: 150),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ImageScreen()),
                );
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
          ],

        ),

      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
      ),
      body: Center(
        child: const Text('Image Screen'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Image App',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: ImportExport(),
  ));
}
