import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/domain/models/password_model.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/helpers/modal_clipboard.dart';
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
  final bool _obscureText = true;

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
          isTitle: true,
          color: Colors.white,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(widget.password.pathLogo, height: 75),
                        const SizedBox(width: 10.0),
                        TextCustom(
                          text: widget.password.nickname,
                          isTitle: true,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    const TextCustom(
                      text: 'Nickname',
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _nicknameController,
                          style: GoogleFonts.poppins(
                              fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Nickname',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const TextCustom(
                      text: 'Email',
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _emailController,
                          style: GoogleFonts.poppins(
                              fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                          cursorColor: ColorsArvi.primary,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const TextCustom(
                      text: 'Password',
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscureText,
                                readOnly: true,
                                style: GoogleFonts.poppins(
                                    fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
                                cursorColor: ColorsArvi.primary,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter password or generate password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _obscureText = !_obscureText;
                          //     });
                          //   },
                          //   icon: Icon(
                          //     _obscureText ? Icons.visibility_off : Icons.visibility,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    if (widget.password.type == 1) ...[
                      const SizedBox(height: 15.0),
                      TextCustom(
                        text: 'Website',
                        isTitle: true,
                        fontWeight: FontWeight.w600,
                        color: Colors.purple.shade600,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextField(
                            controller: _websiteController,
                            style: GoogleFonts.poppins(
                                fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsArvi.primary),
                            cursorColor: ColorsArvi.primary,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter website',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
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
    );
  }
}