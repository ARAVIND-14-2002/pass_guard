// ignore_for_file: use_build_context_synchronously

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pass_guard/presentation/components/animation_route.dart';
import 'package:pass_guard/presentation/screens/auth/login_screen.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:pass_guard/presentation/screens/initial/components/item_menu.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class Biometrics extends StatefulWidget {
  const Biometrics({Key? key}) : super(key: key);

  @override
  State<Biometrics> createState() => _BiometricsState();
}

class _BiometricsState extends State<Biometrics> {
  late final LocalAuthentication auth;
  bool _supportState = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
        _supportState = isSupported;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: <Widget>[
          const Text(
            'Welcome to',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
          ),
          const Text(
            'PassGuard',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.normal),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/img/logo-white.png',
                fit: BoxFit.cover,
                height: 100, // Adjust the height of the image
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ItemMenu(
              icon: FontAwesomeIcons.lock,
              title: 'Number Lock',
              onTap: () {
                Navigator.push(context, routeFade(page: const LoginScreen()));
              },
            ).wrapContainerDecoration(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ItemMenu(
              icon: FontAwesomeIcons.fingerprint,
              title: 'Biometrics',
              onTap: _authenticate,
            ),
          ).wrapContainerDecoration(),
          const SizedBox(height: 50)
        ],
      ),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated == true) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          routeFade(page: const HomeScreen()),
              (_) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          routeFade(page: const Biometrics()),
              (_) => false,
        );
      }

      print('Authenticated: $authenticated');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    print('List of available Biometrics: $availableBiometrics');

    if (!mounted) {
      return;
    }
  }
}

extension ItemMenuExtension on Widget {
  Widget wrapContainerDecoration() {
    return Container(
      height: 60,
      width: 375, // Increase the width of the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4E31AA),
            Color(0x4C4E31AA),
          ],
        ),
      ),
      child: this,
    );
  }
}