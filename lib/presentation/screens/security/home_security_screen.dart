import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/delete/verify_password_delete_screen.dart';
import 'package:pass_guard/presentation/screens/home/components/settings_screen.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:pass_guard/presentation/screens/passwords/generate_password_screen.dart';
import 'package:pass_guard/presentation/screens/security/components/card_item_security.dart';
import 'package:pass_guard/presentation/screens/security/import_export.dart';
import 'package:pass_guard/presentation/screens/security/verify_pin_screen.dart';
import 'package:pass_guard/domain/blocs/auth/auth_bloc.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

import '../home/components/modal_bottom_type_password.dart';

class HomeSecurityScreen extends StatefulWidget {
  const HomeSecurityScreen({Key? key}) : super(key: key);

  @override
  _HomeSecurityScreenState createState() => _HomeSecurityScreenState();
}

class _HomeSecurityScreenState extends State<HomeSecurityScreen> {
  late bool isBiometricEnabled;
  late bool isImageCaptureEnabled;

  @override
  void initState() {
    isBiometricEnabled = true;
    isImageCaptureEnabled = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final securityBloc = BlocProvider.of<SecurityBloc>(context);
    final randomNumberBloc = BlocProvider.of<RandomNumberBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: const TextCustom(
          text: 'Security',
          color: Colors.white,
          isTitle: true,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        // leading: IconButton(
        //   splashRadius: 20,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
        // ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              children: [
                buildSecurityCard(
                  title: 'Change PIN',
                  icon: FontAwesomeIcons.key,
                  onTap: () async {
                    await Navigator.push(context, routeFade(page: const VerifyPinScreen()));
                    securityBloc.add(ClearAllPinEvent());
                  },
                ),
                buildSecurityCard(
                  title: 'Biometric',
                  icon: FontAwesomeIcons.fingerprint,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Biometrics Enabled'),
                      ),
                    );
                  },
                ),
                buildSecurityCard(
                  title: 'Image Capture',
                  icon: FontAwesomeIcons.camera,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Image capture Enabled'),
                      ),
                    );
                  },
                ),
                buildSecurityCard(
                  title: 'Download Backup',
                  icon: FontAwesomeIcons.fileExport,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      routeFade(page: ImportExport()),
                          (route) => true,
                    );
                  },
                ),
                buildSecurityCard(
                  title: 'Password Generator',
                  icon: FontAwesomeIcons.key,
                  onTap: () {
                    Navigator.push(context, routeFade(page: const GeneratePasswordScreen()));
                  },
                ),
              ],
            ),
          ],
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
                  // Navigator.push(
                  //   context,
                  //   routeFade(page: const HomeSecurityScreen()),
                  // );
                },
                icon: const Icon(
                  Icons.security,
                  size: 30,
                  color: Colors.white,
                ),
              ),



              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, routeFade(page: SettingsScreen()), (route) => false);
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
  }

  Widget buildSecurityCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 150,
          height: 150,
          decoration: ShapeDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.30, 0.60),
              radius: 0.75,
              colors: [const Color(0x4C8F02FF), Colors.purple.withOpacity(0.1)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
