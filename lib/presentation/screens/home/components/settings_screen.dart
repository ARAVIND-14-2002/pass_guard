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

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themesBloc = BlocProvider.of<ThemesBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: TextCustom(
          text: 'Settings',
          fontWeight: FontWeight.w600,
          color: Theme.of(context).primaryColor,
        ),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.xmark, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
              ),
              const SizedBox(height: 8.0),
              Text(
                'PassGuard',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // const SizedBox(height: 16.0),
              // const TextCustom(
              //   text: 'Light mode',
              //   color: ColorsFrave.subtitle,
              //   fontSize: 15,
              // ),
              // const SizedBox(height: 10.0),
              // BlocBuilder<ThemesBloc, ThemesState>(
              //   builder: (_, state) {
              //     return AnimatedToggleTheme(
              //       onChanged: () {
              //         themesBloc.add(ChangeThemeToOscureEvent(!state.isOscure));
              //       },
              //     );
              //   },
              // ),
              const SizedBox(height: 15.0),
              const TextCustom(
                text: 'General',
                color: ColorsFrave.subtitle,
                fontSize: 15,
              ),
              const SizedBox(height: 10.0),
              Card(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.lock),
                      title: const Text('Security'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          routeFade(page: const HomeSecurityScreen()),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.barcode),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          routeFade(page: const HomeAboutScreen()),
                        );
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
              Card(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.info),
                      title: const Text('App version                                       v1.5.0'),

                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Theme.of(context).cardTheme.color,
                ),
                onPressed: () {
                  authBloc.add(VerifyAccountEvent());
                  Navigator.pushAndRemoveUntil(
                    context,
                    routeFade(page: const InitialScreen()),
                        (_) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.arrowRightFromBracket,
                      color: ColorsFrave.redLogOut,
                      size: 20,
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}

