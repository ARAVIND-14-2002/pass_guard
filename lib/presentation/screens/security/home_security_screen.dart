import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/security/components/card_item_security.dart';
import 'package:pass_guard/presentation/screens/security/import_export.dart';
import 'package:pass_guard/presentation/screens/security/verify_pin_screen.dart';

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
    isImageCaptureEnabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final securityBloc = BlocProvider.of<SecurityBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Security',
          color: Colors.white,
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardItemSecurity(
                    title: 'Change PIN',
                    prefixWidget: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                    icon: FontAwesomeIcons.key,
                    onTap: () async {
                      await Navigator.push(context, routeFade(page: const VerifyPinScreen()));
                      securityBloc.add(ClearAllPinEvent());
                    },
                  ),
                  CardItemSecurity(
                    title: 'Enabled Biometric',
                    prefixWidget: Switch(
                      value: isBiometricEnabled,
                      onChanged: (value) {
                        setState(() {
                          isBiometricEnabled = value;
                        });
                      },
                      activeTrackColor: Colors.white,
                      activeColor: Color.fromRGBO(36, 255, 0, 1),
                      inactiveTrackColor: Colors.redAccent,
                    ),
                    icon: FontAwesomeIcons.fingerprint,
                  ),
                  CardItemSecurity(
                    title: 'Enable Image-capture',
                    prefixWidget: Switch(
                      value: isImageCaptureEnabled,
                      onChanged: (value) {
                        setState(() {
                          isImageCaptureEnabled = value;
                        });
                      },
                      activeTrackColor: Colors.white,
                      activeColor: Color.fromRGBO(36, 255, 0, 1),
                      inactiveTrackColor: Colors.redAccent,
                    ),
                    icon: FontAwesomeIcons.camera,
                  ),
                  CardItemSecurity(
                    title: 'Download Backup',
                    prefixWidget: const Icon(Icons.arrow_forward_ios_rounded),
                    icon: FontAwesomeIcons.fileExport,
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        routeFade(page: ImportExport()),
                            (route) => true, // Remove all previous routes from the stack
                      );
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
