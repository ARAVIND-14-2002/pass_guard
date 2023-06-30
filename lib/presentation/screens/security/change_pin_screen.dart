import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class ChangePinScreen extends StatefulWidget {

  const ChangePinScreen({Key? key}) : super(key: key);

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {

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
        if(state.successNewPassword){
          Navigator.pushAndRemoveUntil(context, routeFade(page: const HomeScreen()), (_) => false);
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
          text: 'Enter New Master Password',
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
                                state.newNumbers.length >= i + 1
                                ? FontAwesomeIcons.solidCircle
                                : FontAwesomeIcons.circle, 
                                color: state.newNumbers.length >= i + 1
                                ? ColorsArvi.primary
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NumberOption(
                                  text: '${state.listNumberByCreate[0]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[0]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[1]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[1]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[2]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[2]));
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
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[3]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[4]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[4]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[5]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[5]));
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
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[6]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[7]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[7]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[8]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[8]));
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 60.0,),
                                NumberOption(
                                  text: '${state.listNumberByCreate[9]}',
                                  onTap: () {
                                    securityBloc.add(SelectNumberNewPinEvent(state.listNumberByCreate[9]));
                                  },
                                ),
                        Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey.shade100,
                        ),

                             child:   BlocBuilder<SecurityBloc, SecurityState>(
                                  builder: (_, stateSecurity) {
                                    return IconButton(
                                      splashRadius: 60,
                                      onPressed: (){
                                        securityBloc.add(ClearLastNumberNewPinEvent(stateSecurity.newNumbers.length));
                                      },
                        icon: const Icon(
                        FontAwesomeIcons.xmarkCircle,
                        color: Colors.black,
                        ),
                                    );
                                  }
                                )
                        ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 80.0)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}