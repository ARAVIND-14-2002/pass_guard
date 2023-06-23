import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/delete/verify_password_delete_screen.dart';
import 'package:pass_guard/presentation/screens/passwords/generate_password_screen.dart';
import 'package:pass_guard/presentation/screens/security/components/card_item_security.dart';
import 'package:pass_guard/presentation/screens/security/import_export.dart';
import 'package:pass_guard/presentation/screens/security/verify_pin_screen.dart';
import 'package:pass_guard/domain/blocs/auth/auth_bloc.dart';

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
                          // isBiometricEnabled = value;
                        });
                      },
                      activeTrackColor: Colors.white,
                      activeColor: const Color.fromRGBO(36, 255, 0, 1),
                      inactiveTrackColor: Colors.redAccent,
                    ),
                    icon: FontAwesomeIcons.fingerprint,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Disable feature not Available'),
                        ),
                      );
                    },
                  ),
                  CardItemSecurity(
                    title: 'Enable Image-capture',
                    prefixWidget: Switch(
                      value: isImageCaptureEnabled,
                      onChanged: (value) {
                        setState(() {
                          // isImageCaptureEnabled = value;
                        });
                      },
                      activeTrackColor: Colors.white,
                      activeColor: const Color.fromRGBO(36, 255, 0, 1),
                      inactiveTrackColor: Colors.redAccent,
                    ),
                    icon: FontAwesomeIcons.camera,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Disable feature not Available'),
                        ),
                      );
                    },
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

                  CardItemSecurity(
                    title: 'Password Generator',
                    prefixWidget: const Icon(Icons.arrow_forward_ios_rounded),
                    icon: FontAwesomeIcons.key,
                    onTap: () {
                      Navigator.push(context, routeFade(page: const GeneratePasswordScreen()));
                    },
                  ),


                  // CardItemSecurity(
                  //   title: 'Delete',
                  //   prefixWidget: const Icon(Icons.arrow_forward_ios_rounded),
                  //   icon: FontAwesomeIcons.lock,
                  //   onTap: () {
                  //     var state;
                  //     if (state.existAccount) {
                  //       randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                  //       Navigator.push(context, routeFade(page: const VerifyPasswordDeleteScreen())).then((_) {
                  //         authBloc.add(ClearAllNumbersEvent());
                  //       });
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
