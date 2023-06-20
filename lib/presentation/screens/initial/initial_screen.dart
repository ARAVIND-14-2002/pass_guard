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
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:pass_guard/presentation/screens/auth/biometrics.dart';
import 'components/item_menu.dart';



class InitialScreen extends StatelessWidget {

  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final randomNumberBloc = BlocProvider.of<RandomNumberBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
     DateTime now = DateTime.now();

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                          text: now.hour >= 18
                            ? 'PassGuard'
                            : 'PassGuard',
                          isTitle: true, 
                          fontSize: 22, 
                          fontWeight: FontWeight.w600, 
                          color:now.hour >= 18 ? Colors.white : Colors.white
                        ),
                        Icon(FontAwesomeIcons.lock, color: now.hour >= 18 ? Colors.white : Colors.white )
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (_, state) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: Icon(state.existAccount ? FontAwesomeIcons.user : FontAwesomeIcons.solidFaceSadTear, size: 15, color: Colors.white),
                              ),
                              const SizedBox(width: 10.0),
                              TextCustom(
                                text: state.existAccount ? 'Main Account' : 'No account', 
                                isTitle: true,
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
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
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemMenu(
                                icon: FontAwesomeIcons.circlePlus,
                                title: 'Create',
                                isDisable: state.existAccount,
                                onTap: (){
                                  if(!state.existAccount){
                                    randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                                    Navigator.push(context, routeFade(page: const CreateAccountScreen()));
                                  }
                                },
                              ),
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
                              ),
                              ItemMenu(
                                icon: FontAwesomeIcons.lock,
                                title: 'Delete',
                                isDisable: !state.existAccount,
                                onTap: (){
                                  if(state.existAccount){
                                    randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                                    Navigator.push(context, routeFade(page: const VerifyPasswordDeleteScreen())).then((_){
                                      authBloc.add(ClearAllNumbersEvent());
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemMenu(
                            icon: FontAwesomeIcons.paperPlane,
                            title: 'Privacy Policy',
                            onTap: (){
                              Navigator.push(context, routeFade(page: const PrivacyPolicyScreen()));
                            },
                          ),
                          ItemMenu(
                            icon: FontAwesomeIcons.barcode,
                            title: 'About',
                            onTap: (){
                              Navigator.push(context, routeFade(page: HomeAboutScreen()));
                            },
                          ),
                          ItemMenu(
                            icon: FontAwesomeIcons.key,
                            title: 'Generate',
                            onTap: (){
                              Navigator.push(context, routeFade(page: const GeneratePasswordScreen()));
                            },
                          ),
                        ],
                      ),
                      
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




