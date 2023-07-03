import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/Camera/camera_capture_screen.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';
import 'package:vibration/vibration.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LocalAuthentication auth;
  int _incorrectAttempts = 0;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.numbers.length == 6) {
          Future.delayed(const Duration(milliseconds: 350)).then((_) {
            authBloc.add(VerifyPasswordEvent());
          });
        }
        if (state.isSuccessPassword) {
          authBloc.add(ClearAllNumbersEvent());
          Navigator.pushAndRemoveUntil(
            context,
            routeFade(page: const HomeScreen()),
                (_) => false,
          );
        } else if (state.isFailPassword && state.numbers.length == 6) {
          _incorrectAttempts++;
          if (_incorrectAttempts >= 3) {
            Navigator.pushAndRemoveUntil(
              context,
              routeFade(page: CameraCaptureScreen()),
                  (route) => false,
            );
            _incorrectAttempts = 0; // Reset the incorrect count
          } else {
            Vibration.vibrate(
                duration: 500); // Vibrate the device for 500 milliseconds
            Future.delayed(const Duration(milliseconds: 500)).then((_) {
              authBloc.add(ClearAllNumbersEvent());
            });
          }
        }

      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                authBloc.add(ClearAllNumbersEvent());
                Navigator.pop(context);
                _incorrectAttempts = 0; // Reset the incorrect count
              },
              icon: const Icon(FontAwesomeIcons.xmark, size: 20.0),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/img/logo-white.png',
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: TextCustom(
                      text: 'Enter Master Password',
                      fontSize: 24,
                      isTitle: true,
                      color: Color(0xfff5f5f7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (_, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              6,
                                  (i) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Icon(
                                  state.numbers.length > i
                                      ? FontAwesomeIcons.solidCircle
                                      : FontAwesomeIcons.circle,
                                  color: state.isFailPassword && state.numbers.length == 6
                                      ? Colors.red
                                      : ColorsArvi.primary,
                                  size: MediaQuery.of(context).size.width * 0.08,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      BlocBuilder<RandomNumberBloc, RandomNumberState>(
                        builder: (_, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[0]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[0]));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[1]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[1]));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[2]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[2]));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // Second Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[3]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[3]));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[4]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[4]));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[5]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[5]));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              // ...

                              const SizedBox(height: 10.0),
                              // Third Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[6]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[6]));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[7]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[7]));
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: NumberOption(
                                      text: '${state.listNumberByCreate[8]}',
                                      onTap: () {
                                        authBloc.add(SelectNumberEvent(state.listNumberByCreate[8]));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),

                              // Fourth Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(width: 60.0),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[9]}',
                                    onTap: () {
                                      authBloc.add(SelectNumberEvent(state.listNumberByCreate[9]));
                                    },
                                  ),

                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueGrey.shade100,
                                    ),
                                    child: BlocBuilder<AuthBloc, AuthState>(
                                      builder: (_, stateAuth) => IconButton(
                                        splashRadius: 60,
                                        onPressed: () {
                                          authBloc.add(ClearLastNumberEvent(stateAuth.numbers.length));
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.xmarkCircle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

