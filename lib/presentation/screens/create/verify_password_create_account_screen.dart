import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class VerifyPasswordCreateAccountScreen extends StatefulWidget {
  const VerifyPasswordCreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordCreateAccountScreen> createState() => _VerifyPasswordCreateAccountScreenState();
}

class _VerifyPasswordCreateAccountScreenState extends State<VerifyPasswordCreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final createAccountBloc = BlocProvider.of<CreateAccountBloc>(context);

    return BlocListener<CreateAccountBloc, CreateAccountState>(
      listener: (context, state) {
        if (state.verifyNumbersCreate.length == 6) {
          Future.delayed(const Duration(milliseconds: 350)).then((_) {
            createAccountBloc.add(VerifyPasswordsByCreateAccountEvent());
          });
        }
        if (state.isSuccessCreateAccount) {
          Navigator.pushAndRemoveUntil(context, routeFade(page: const HomeScreen()), (_) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: () {
                createAccountBloc.add(ResetValuesCreateAccountEvent());
                createAccountBloc.add(ClearNumberRepeatByCreateAccountEvent());
                Navigator.pop(context);
              },
              icon: const Icon(FontAwesomeIcons.xmark, size: 20.0),
            )
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
                  text: 'Confirm Your Password',
                  fontSize: 24,
                  isTitle: true,
                  color: Color(4294309367),
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
                        state.verifyNumbersCreate.length >= i + 1
                            ? FontAwesomeIcons.solidCircle
                            : FontAwesomeIcons.circle,
                        color: state.verifyNumbersCreate.length >= i + 1
                            ? state.isFailurePassword ? Colors.red : ColorsArvi.primary
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
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[0]));
                            },
                          ),
                          NumberOption(
                            text: '${state.listNumberByCreate[1]}',
                            onTap: () {
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[1]));
                            },
                          ),
                          NumberOption(
                            text: '${state.listNumberByCreate[2]}',
                            onTap: () {
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[2]));
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
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[3]));
                            },
                          ),
                          NumberOption(
                            text: '${state.listNumberByCreate[4]}',
                            onTap: () {
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[4]));
                            },
                          ),
                          NumberOption(
                            text: '${state.listNumberByCreate[5]}',
                            onTap: () {
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[5]));
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
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[6]));
                            },
                          ),
                          NumberOption(
                            text: '${state.listNumberByCreate[7]}',
                            onTap: () {
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[7]));
                            },
                          ),
                          NumberOption(
                            text: '${state.listNumberByCreate[8]}',
                            onTap: () {
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[8]));
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
                              createAccountBloc.add(SelectNumberRepeatByCreateAccountEvent(state.listNumberByCreate[9]));
                            },
                          ),
                  Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey.shade100,
                  ),
                    child:BlocBuilder<CreateAccountBloc, CreateAccountState>(
                            builder: (_, stateAccount) => IconButton(
                              splashRadius: 60,
                              onPressed: () {
                                createAccountBloc.add(ClearLastNumberRepeatByCreateAccountEvent(stateAccount.verifyNumbersCreate.length));
                              },
                              icon: const Icon(FontAwesomeIcons.xmarkCircle, color: Colors.black),
                            ),
                          )
                  )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
      ),
    ),)
    );
  }
}
