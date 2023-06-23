import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/domain/models/password_model.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/helpers/modal_clipboard.dart';
import 'package:pass_guard/presentation/screens/home/components/settings_screen.dart';
import 'package:pass_guard/presentation/screens/home/home_screen.dart';
import 'package:pass_guard/presentation/screens/security/home_security_screen.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class ViewPasswordScreen extends StatefulWidget {
  final PasswordModel password;
  final int index;

  const ViewPasswordScreen({Key? key, required this.password, required this.index})
      : super(key: key);

  @override
  State<ViewPasswordScreen> createState() => _ViewPasswordScreenState();
}

class _ViewPasswordScreenState extends State<ViewPasswordScreen> {
  late TextEditingController _nicknameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _websiteController;
  late final PasswordBloc passwordBloc;
  late final HomeBloc homeBloc;
  bool isPasswordVisible = false;
  bool isEditing = false;

  @override
  void initState() {
    passwordBloc = BlocProvider.of<PasswordBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    _nicknameController = TextEditingController(text: widget.password.nickname);
    _emailController = TextEditingController(text: widget.password.email);
    _passwordController = TextEditingController(text: widget.password.password);
    _websiteController = TextEditingController(text: widget.password.website);
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Vault',
          color: Colors.grey,
          isTitle: true,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19.0),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(widget.password.pathLogo, height: 50),
                        const SizedBox(width: 10.0),
                        TextCustom(
                          text: widget.password.nickname,
                          isTitle: true,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    buildEditableTextFormField(
                      title: 'Website/App',
                      color: Colors.white,
                      controller: _nicknameController,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 15.0),
                    buildEditableTextFormField(
                      color: Colors.white,
                      title: 'Email',
                      controller: _emailController,
                      isEditing: isEditing,
                    ),
                    const SizedBox(height: 15.0),
                    buildEditableTextFormField(
                      title: 'Password',
                      color: Colors.white,
                      controller: _passwordController,
                      isEditing: isEditing,
                      obscureText: !isPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (widget.password.type == 1) ...[
                      const SizedBox(height: 15.0),
                      buildEditableTextFormField(
                        title: 'Website',
                        color: Colors.white,
                        controller: _websiteController,
                        isEditing: isEditing,
                      ),
                    ],
                    const SizedBox(height: 10.0),
                    const Divider(),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        modalClipBoard(context, 'Copied');
                        passwordBloc.add(CopyPasswordEvent(widget.password));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        child: const Row(
                          children: [
                            Icon(FontAwesomeIcons.clone),
                            SizedBox(width: 10.0),
                            TextCustom(
                              text: 'Copy',
                              color: Colors.white,
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        passwordBloc.add(DeletePasswordEvent(widget.index));
                        Navigator.pop(context);
                        homeBloc.add(GetPasswordAndStadisticHomeEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.trashCan, color: Colors.red.shade600),
                            const SizedBox(width: 10.0),
                            TextCustom(
                              text: 'Delete',
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: ColorsFrave.primary,
        child: Container(
          decoration: BoxDecoration(
            // gradient: ColorsFrave.bottomAppBarGradient,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, routeFade(page: HomeScreen()), (route) => false);
                },
                icon: const Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, routeFade(page: HomeSecurityScreen()), (route) => false);
                },
                icon: const Icon(
                  Icons.security,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, routeFade(page: SettingsScreen()), (route) => false);
                },
                icon: const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'edit-password',
      //   backgroundColor: ColorsFrave.primary,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30.0),
      //   ),
      //   child: Icon(isEditing ? FontAwesomeIcons.save : FontAwesomeIcons.edit, color: Colors.white),
      //   onPressed: () {
      //     setState(() {
      //       isEditing = !isEditing;
      //     });
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildEditableTextFormField({
    required String title,
    required Color color,
    required TextEditingController controller,
    required bool isEditing,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextCustom(
          text: 'Website/App',
          isTitle: true,
          fontWeight: FontWeight.w600,
          color: ColorsFrave.primary,
        ),
        const SizedBox(height: 5.0),
        Container(
          decoration: BoxDecoration(
            color: isEditing ? Colors.grey.shade200 : null,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: !isEditing,
            obscureText: obscureText,
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            cursorColor: ColorsFrave.primary,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter $title',
              hintStyle: GoogleFonts.poppins(color: Colors.grey),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}

