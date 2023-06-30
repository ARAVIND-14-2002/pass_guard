import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportProblemScreen extends StatelessWidget {

  const ReportProblemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Report a Problem',
          isTitle: true,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22)
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo-white.png', height: 160.0),
            const SizedBox(height: 10.0),
            const TextCustom(
              text: 'Pass Guard',
              isTitle: true,
              fontWeight: FontWeight.bold,
              fontSize: 32,
              textAlign: TextAlign.center,
              color: ColorsArvi.primary,
            ),
            const SizedBox(height: 20.0),
            IconButton(
              splashRadius: 20,
              onPressed: (){
                launchUrl(Uri.parse(''), mode: LaunchMode.externalApplication);
              }, 
              icon: const Icon(FontAwesomeIcons.iceCream, size: 45)
            ),
          ],
        ),
      ),
    );
  }
}