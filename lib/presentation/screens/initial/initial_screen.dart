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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 0.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                          text: 'PassGuard',
                          isTitle: true,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        Icon(FontAwesomeIcons.lock, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (_, state) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                            color: ColorsFrave.primary.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                state.existAccount
                                    ? FontAwesomeIcons.smile
                                    : FontAwesomeIcons.solidFaceGrin,
                                size: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10.0),
                              TextCustom(
                                text: state.existAccount ? 'Good to See you Back!' : 'Hello there!!',
                                isTitle: true,
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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

                              SizedBox(height: 20), // Increase spacing between ItemMenu widgets

                              ItemMenu(
                                icon: FontAwesomeIcons.rightToBracket,
                                title: 'Log In',
                                isDisable: !state.existAccount,
                                onTap: () async {
                                  if(state.existAccount){
                                    randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                                    Navigator.push(context, routeFade(page: const Biometrics())).then((_) {
                                      authBloc.add(ClearAllNumbersEvent());
                                    });
                                  }
                                },
                              ).wrapContainerDecoration(),

                              SizedBox(height: 20), // Increase spacing between ItemMenu widgets

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
                      const SizedBox(height: 0.0),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension ItemMenuExtension on ItemMenu {
  Widget wrapContainerDecoration() {
    return Container(
      width: double.infinity, // Increase the width of the container
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 1, 0, 41).withOpacity(0.5),
            ColorsFrave.primary.withOpacity(0.4),
          ],
        ),
      ),
      child: this,
    );
  }
}
