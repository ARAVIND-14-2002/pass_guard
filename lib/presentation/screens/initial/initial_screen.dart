import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/animation_route.dart';
import 'package:pass_guard/presentation/components/text_custom.dart';
import 'package:pass_guard/presentation/screens/Camera/camera_capture_screen.dart';
import 'package:pass_guard/presentation/screens/about/home_about_screen.dart';
import 'package:pass_guard/presentation/screens/about/privacy_policy_screen.dart';
import 'package:pass_guard/presentation/screens/auth/login_screen.dart';
import 'package:pass_guard/presentation/screens/create/create_account_screen.dart';
import 'package:pass_guard/presentation/screens/delete/verify_password_delete_screen.dart';
import 'package:pass_guard/presentation/screens/initial/components/background_initial.dart';
import 'package:pass_guard/presentation/screens/passwords/generate_password_screen.dart';
import 'package:pass_guard/presentation/screens/report_problem/report_problem_screen.dart';
import 'package:pass_guard/presentation/screens/security/image_capture_screen.dart';
import 'package:pass_guard/presentation/screens/home/components/settings_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:pass_guard/presentation/screens/auth/biometrics.dart';
import 'components/item_menu.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomNumberBloc = BlocProvider.of<RandomNumberBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundInitial(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ItemMenu(
                          icon: FontAwesomeIcons.circlePlus,
                          title: 'Create',
                          isDisable: state.existAccount,
                          onTap: () {
                            if (!state.existAccount) {
                              randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                              Navigator.push(context, routeFade(page: const CreateAccountScreen()));
                            }
                          },
                        ).wrapContainerDecoration(),
                        const SizedBox(height: 25),
                        ItemMenu(
                          icon: FontAwesomeIcons.rightToBracket,
                          title: 'Log In',
                          isDisable: !state.existAccount,
                          onTap: () async {
                            if (state.existAccount) {
                              randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                              Navigator.push(context, routeFade(page: const Biometrics())).then((_) {
                                authBloc.add(ClearAllNumbersEvent());
                              });
                            }
                          },
                        ).wrapContainerDecoration(),
                        const SizedBox(height: 20),
                        // ItemMenu(
                        //   icon: FontAwesomeIcons.xmarkCircle,
                        //   title: 'Delete',
                        //   isDisable: !state.existAccount,
                        //   onTap: () {
                        //     if (state.existAccount) {
                        //       randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                        //       Navigator.push(context, routeFade(page: const VerifyPasswordDeleteScreen())).then((_) {
                        //         authBloc.add(ClearAllNumbersEvent());
                        //       });
                        //     }
                        //   },
                        // ).wrapContainerDecoration(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ItemMenu(
                //       icon: FontAwesomeIcons.paperPlane,
                //       title: 'Privacy Policy',
                //       onTap: () {
                //         Navigator.push(context, routeFade(page: const PrivacyPolicyScreen()));
                //       },
                //     ),
                //     ItemMenu(
                //       icon: FontAwesomeIcons.barcode,
                //       title: 'About',
                //       onTap: () {
                //         Navigator.push(context, routeFade(page: HomeAboutScreen()));
                //       },
                //     ),
                //     ItemMenu(
                //       icon: FontAwesomeIcons.key,
                //       title: 'Generate',
                //       onTap: () {
                //         Navigator.push(context, routeFade(page: const GeneratePasswordScreen()));
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension ItemMenuExtension on ItemMenu {
  Widget wrapContainerDecoration() {
    return Container(
      height: 60,
      width: 375, // Increase the width of the container
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
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