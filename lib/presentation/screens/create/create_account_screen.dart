import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/create/verify_password_create_account_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final createAccountBloc = BlocProvider.of<CreateAccountBloc>(context);

    return BlocListener<CreateAccountBloc, CreateAccountState>(
      listener: (context, state) async {
        if (state.numbersCreate.length == 6) {
          await Future.delayed(const Duration(milliseconds: 350)).then((_) {
            Navigator.pushReplacement(
              context,
              routeFade(page: const VerifyPasswordCreateAccountScreen()),
            );
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.pop(context);
                createAccountBloc.add(ResetValuesCreateAccountEvent());
              },
              icon: const Icon(FontAwesomeIcons.xmark, size: 20.0),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/logo-white.png', // Replace with your image path
                        height: 80,
                      ),
                      const SizedBox(height: 40.0),
                      const Center(
                        child: TextCustom(
                          text: 'Enter a new password',
                          fontSize: 24,
                          isTitle: true,
                          color: Color(4294309367),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      BlocBuilder<CreateAccountBloc, CreateAccountState>(
                        builder: (_, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(6, (i) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                state.numbersCreate.length >= i + 1
                                    ? FontAwesomeIcons.solidCircle
                                    : FontAwesomeIcons.circle,
                                color: state.numbersCreate.length >= i + 1
                                    ? ColorsArvi.primary
                                    : Color(4294309367),
                                size: MediaQuery.of(context).size.width * 0.08,
                              ),
                            )),
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      BlocBuilder<RandomNumberBloc, RandomNumberState>(
                        builder: (_, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumberOption(
                                    text: '${state.listNumberByCreate[0]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[0]),
                                      );
                                    },
                                  ),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[1]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[1]),
                                      );
                                    },
                                  ),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[2]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[2]),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumberOption(
                                    text: '${state.listNumberByCreate[3]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[3]),
                                      );
                                    },
                                  ),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[4]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[4]),
                                      );
                                    },
                                  ),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[5]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[5]),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  NumberOption(
                                    text: '${state.listNumberByCreate[6]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[6]),
                                      );
                                    },
                                  ),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[7]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[7]),
                                      );
                                    },
                                  ),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[8]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[8]),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(width: 70.0),
                                  NumberOption(
                                    text: '${state.listNumberByCreate[9]}',
                                    onTap: () {
                                      createAccountBloc.add(
                                        SelectNumberByCreateAccountEvent(state.listNumberByCreate[9]),
                                      );
                                    },
                                  ),
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueGrey.shade100,
                                    ),
                                    child: BlocBuilder<CreateAccountBloc, CreateAccountState>(
                                      builder: (_, stateAccount) => IconButton(
                                        splashRadius: 60,
                                        onPressed: () {
                                          createAccountBloc.add(
                                            ClearLastNumberByCreateAccountEvent(stateAccount.numbersCreate.length),
                                          );
                                        },
                                        icon: const Icon(FontAwesomeIcons.xmarkCircle, color: Colors.black),
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
                ),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
