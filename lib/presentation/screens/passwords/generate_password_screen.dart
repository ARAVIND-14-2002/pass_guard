import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/helpers/modal_clipboard.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class GeneratePasswordScreen extends StatefulWidget {
  const GeneratePasswordScreen({Key? key}) : super(key: key);

  @override
  State<GeneratePasswordScreen> createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {
  late final TextEditingController _passwordController;
  late final GeneratePasswordBloc _generatePasswordBloc;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _generatePasswordBloc = BlocProvider.of<GeneratePasswordBloc>(context);
    _generatePasswordBloc.add(GeneratePasswordFirstEvent());
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Generate Password',
          color: Colors.white,
          isTitle: true,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        // leading: IconButton(
        //   splashRadius: 20,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextCustom(
                text: 'GENERATED PASSWORD',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              const SizedBox(height: 5.0),
              BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                builder: (_, state) {
                  _passwordController.text = state.password;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: _passwordController,
                      style: GoogleFonts.poppins(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'password',
                        hintStyle: GoogleFonts.poppins(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              const TextCustom(
                text: 'LENGTH: ',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              const SizedBox(height: 5.0),
              BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        child: const TextCustom(
                          text: '0',
                          isTitle: true,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Expanded(
                        child: Slider(
                          value: state.length.toDouble(),
                          min: 0,
                          max: 40,
                          label: '${state.length}',
                          activeColor: ColorsArvi.primary,
                          inactiveColor: Colors.grey,
                          onChanged: (value) {
                            _generatePasswordBloc.add(LengthPasswordEvent(value));
                          },
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        child: TextCustom(
                          text: '${state.length}',
                          isTitle: true,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 25.0),
              const TextCustom(
                text: 'SETTINGS: ',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              const SizedBox(height: 10.0),
              buildSettingRow(
                text: 'Uppercase letters',
                stateSelector: (state) => state.uppercase,
                eventCreator: (state) => GeneratePasswordUppercaseEvent(!state.uppercase),
              ),
              const SizedBox(height: 10.0),
              buildSettingRow(
                text: 'Lowercase letters',
                stateSelector: (state) => state.lowercase,
                eventCreator: (state) => GeneratePasswordLowercaseEvent(!state.lowercase),
              ),
              const SizedBox(height: 10.0),
              buildSettingRow(
                text: 'Numbers',
                stateSelector: (state) => state.numbers,
                eventCreator: (state) => GeneratePasswordNumbersEvent(!state.numbers),
              ),
              const SizedBox(height: 10.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextCustom(
                      text: 'Special symbols'
                    ),
                    BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                      builder: (_, state) {
                        return GestureDetector(
                          onTap: (){
                            if(state.uppercase || state.lowercase || state.numbers){
                              _generatePasswordBloc.add(GeneratePasswordSpecialEvent(!state.specialCharacters));
                            }
                          },
                          child: AnimatedToggle(
                            isActive: state.specialCharacters
                          ),
                        );
                      }
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: BtnCustom(
                text: 'COPY',
                border: 50,
                fontWeight: FontWeight.bold,
                isTitle: true,
                width: double.infinity,
                onTap: () {
                  modalClipBoard(context, 'Copied');
                  _generatePasswordBloc.add(CopyPasswordGenerateEvent(_passwordController.text.trim()));
                },
              ),
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                _generatePasswordBloc.add(RefreshPasswordEvent());
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: ColorsArvi.primary.withOpacity(.2),
                ),
                child: const Icon(FontAwesomeIcons.rotate, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSettingRow({
    required String text,
    required bool Function(GeneratePasswordState) stateSelector,
    required GeneratePasswordEvent Function(GeneratePasswordState) eventCreator,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextCustom(text: text),
          BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
            builder: (_, state) {
              final isActive = stateSelector(state);
              return GestureDetector(
                onTap: () {
                  final event = eventCreator(state);
                  if (event != null) {
                    _generatePasswordBloc.add(event);
                  }
                },
                child: AnimatedToggle(isActive: isActive),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AnimatedToggle extends StatelessWidget {
  final bool isActive;
  const AnimatedToggle({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 20.0,
      width: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isActive ? Colors.green : Colors.grey.shade300,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 2.0,
            left: isActive ? 20.0 : 0.0,
            right: isActive ? 0.0 : 20.0,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: isActive
                    ? const Icon(
                  FontAwesomeIcons.solidCheckCircle,
                  key: Key('true'),
                  color: Colors.white,
                  size: 16.0,
                )
                    : Icon(
                  FontAwesomeIcons.circle,
                  key: const Key('false'),
                  color: Colors.grey.shade300,
                  size: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
