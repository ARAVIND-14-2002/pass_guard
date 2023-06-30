import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/about/home_about_screen.dart';
import 'package:pass_guard/presentation/screens/initial/initial_screen.dart';
import 'package:pass_guard/presentation/screens/security/home_security_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';


import 'animated_toggle_theme.dart';
import 'item_modal_setting.dart';

void modalSettings(BuildContext context){

  final themesBloc = BlocProvider.of<ThemesBloc>(context);
  final authBloc = BlocProvider.of<AuthBloc>(context);
  final size = MediaQuery.of(context).size;

  showGeneralDialog(
    context: context,
    barrierColor: Colors.black54, 
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, animation, _, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          content: SizedBox(
            width: size.width,
            height: size.height * .85,
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                        text: 'Settings',
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(FontAwesomeIcons.xmark, color: Colors.red)
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 5.0),
                  const TextCustom(
                    text: 'Light mode',
                    color: ColorsArvi.subtitle,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<ThemesBloc, ThemesState>(
                    builder: (_, state) {
                      return AnimatedToggleTheme(
                        onChanged: () {
                          themesBloc.add(ChangeThemeToOscureEvent(!state.isOscure));
                        },
                      );
                    }
                  ),
                  const SizedBox(height: 15.0),
                  const TextCustom(
                    text: 'General',
                    color: ColorsArvi.subtitle,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Column(
                      children: [
                        ItemModalSetting(
                          text: 'Security',
                          icon: FontAwesomeIcons.lock,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, routeFade(page: const HomeSecurityScreen()));
                          },
                        ),
                        const Divider(),
                        ItemModalSetting(
                          text: 'About',
                          icon: FontAwesomeIcons.faceSmile,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, routeFade(page: const HomeAboutScreen()));
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15.0),
                  const TextCustom(
                    text: 'More',
                    color: Color(0xff6a6570),
                    fontSize: 15,
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Column(
                      children: [
                        ItemModalSetting(
                          text: 'App version                    v1.5.0',
                          icon: FontAwesomeIcons.info,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      authBloc.add(VerifyAccountEvent());
                      Navigator.pushAndRemoveUntil(context, routeFade(page: const InitialScreen()), (_) => false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.arrowRightFromBracket, color: ColorsArvi.redLogOut, size: 20),
                          SizedBox(width: 10.0),
                          TextCustom(
                            text: 'Log out',
                            isTitle: true,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    pageBuilder: (_, __, ___) => const SizedBox(),
  );
}