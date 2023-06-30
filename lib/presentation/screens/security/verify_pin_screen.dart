import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/security/change_pin_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class VerifyPinScreen extends StatefulWidget {

  const VerifyPinScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPinScreen> createState() => _VerifyPinScreenState();
}

class _VerifyPinScreenState extends State<VerifyPinScreen> {

  late final SecurityBloc securityBloc;

  @override
  void initState() {
    securityBloc = BlocProvider.of<SecurityBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return BlocListener<SecurityBloc, SecurityState>(
      listener: (context, state) {
        if(state.isSuccessPassword){
          Navigator.pushReplacement(context, routeFade(page: const ChangePinScreen()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: const Icon(FontAwesomeIcons.xmark, size: 20.0)
            )
          ],
        ),
    body: SafeArea(
    child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
    child: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Image.asset(
    'assets/img/logo-white.png', // Replace with your image path
    height: 80,
    ),
    const Center(
    child: TextCustom(
    text: 'Enter Master Password',
    fontSize: 24,
    isTitle: true,
    color: Color(4294309367),
    ),
    ),
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    BlocBuilder<SecurityBloc, SecurityState>(
                      builder: (_, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (i) 
                            => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                state.numbers.length >= i + 1
                                ? FontAwesomeIcons.solidCircle
                                : FontAwesomeIcons.circle, 
                                color: state.numbers.length >= i + 1
                                ? state.isFailurePassword
                                  ? Colors.red
                                  : ColorsArvi.primary
                                : Color(4294309367),
                                size: 40.0
                              ),
                            )
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
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[0]));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: NumberOption(
                                    text: '${state.listNumberByCreate[1]}',
                                    onTap: () {
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[1]));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: NumberOption(
                                    text: '${state.listNumberByCreate[2]}',
                                    onTap: () {
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[2]));
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
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[3]));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: NumberOption(
                                    text: '${state.listNumberByCreate[4]}',
                                    onTap: () {
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[4]));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: NumberOption(
                                    text: '${state.listNumberByCreate[5]}',
                                    onTap: () {
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[5]));
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
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[6]));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: NumberOption(
                                    text: '${state.listNumberByCreate[7]}',
                                    onTap: () {
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[7]));
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: NumberOption(
                                    text: '${state.listNumberByCreate[8]}',
                                    onTap: () {
                                      securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[8]));
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
                                    securityBloc.add(SelectNumberVerifyPinEvent(state.listNumberByCreate[9]));
                                  },
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blueGrey.shade100,
                                  ),
                                  child: BlocBuilder<SecurityBloc, SecurityState>(
                                          builder: (_, stateSecurity) {
                                            return IconButton(
                                              splashRadius: 60,
                                              onPressed: () {
                                                securityBloc.add(
                                                    ClearLastNumberVerifyPinEvent(
                                                        stateSecurity.numbers
                                                            .length));
                                              },
                                              icon: const Icon(
                                                FontAwesomeIcons.xmarkCircle,
                                                color: Colors.black,
                                              ),
                                            );
                                          }
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
      const SizedBox(height: 80),
    ],
    ),
    ),
    ),
    ),
      ),
    );
  }
}