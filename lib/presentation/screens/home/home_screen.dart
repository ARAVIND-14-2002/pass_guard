import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/helpers/snack_messages.dart';
import 'package:pass_guard/presentation/screens/card/home_card_screen.dart';
import 'package:pass_guard/presentation/screens/home/app_password_screen.dart';
import 'package:pass_guard/presentation/screens/home/browser_password_screen.dart';
import 'package:pass_guard/presentation/screens/home/components/card_home_header.dart';
import 'package:pass_guard/presentation/screens/home/components/modal_bottom_type_password.dart';
import 'package:pass_guard/presentation/screens/home/components/settings_screen.dart';
import 'package:pass_guard/presentation/screens/home/components/recentrly_added.dart';
import 'package:pass_guard/presentation/screens/passwords/modal_add_password_home.dart';
import 'package:pass_guard/presentation/screens/security/home_security_screen.dart';
import 'package:pass_guard/presentation/screens/security/import_export.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  late TextEditingController _searchController;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetPasswordAndStadisticHomeEvent());
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PasswordBloc, PasswordState>(
          listener: (context, state) {
            if (state is SuccessCreatePasswordStatus) {
              homeBloc.add(GetPasswordAndStadisticHomeEvent());
            }
            if (state is SuccessFailurePasswordStatus) {
              snackMessageSuccess(context, 'Deleted');
            }
          },
        ),
      ],

      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PassGuard',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              // Container(
              //
              //   padding: EdgeInsets.symmetric(vertical:0),
              //   child: TextFormField(
              //
              //     controller: _searchController,
              //     style: TextStyle(
              //       fontSize: 16.0,
              //       color: Colors.white,
              //     ),
              //
              //     decoration: InputDecoration(
              //       hintText: 'Search',
              //       hintStyle: TextStyle(
              //         fontSize: 16.0,
              //         color: Colors.white.withOpacity(0.7),
              //       ),
              //       contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              //       filled: true,
              //       fillColor: Colors.grey.shade800,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(8.0),
              //         borderSide: BorderSide.none,
              //       ),
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Colors.white.withOpacity(0.7),
              //       ),
              //     ),
              //     onChanged: (value) {
              //       // Handle search
              //     },
              //   ),
              // ),
            ],
          ),

        ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                const SizedBox(height: 20.0),
                TextCustom(
                  text: 'Categories',
                  isTitle: true,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10.0),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (_, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CardHomeHeader(
                            title: 'Browser',
                            subtitle: '${state.passwordBrowser.length} password',
                            icon: FontAwesomeIcons.earthAmericas,
                            color: const Color(0xffaa79ff),
                            onTap: () async {
                              await Navigator.push(context, routeFade(page: const BrowserPasswordScreen()));
                              homeBloc.add(ClearSearchBrowserPasswordEvent());
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CardHomeHeader(
                            title: 'Apps',
                            subtitle: '${state.passwordApp.length} password',
                            icon: FontAwesomeIcons.mobileScreen,
                            color: const Color(0xff66ff66),
                            onTap: () async {
                              await Navigator.push(context, routeFade(page: const AppPasswordScreen()));
                              homeBloc.add(ClearSearchAppPasswordEvent());
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CardHomeHeader(
                            title: 'Card',
                            subtitle: 'Cards',
                            // subtitle: '${state.cardStadistcs} cards',
                            icon: FontAwesomeIcons.creditCard,
                            color: const Color(0xff387EDD),
                            onTap: () {
                              Navigator.push(context, routeFade(page: const HomeCardScreen()));
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                TextCustom(
                  text: 'My Passwords',
                  isTitle: true,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: RecentrlyAdded(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(8.0),
          //   topRight: Radius.circular(8.0),
          // ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: ColorsArvi.primary,
            child: Container(
              decoration: BoxDecoration(
                // gradient: ColorsArvi.bottomAppBarGradient,
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
        ),


        floatingActionButton: FloatingActionButton(
          heroTag: 'add-password',
          backgroundColor: ColorsArvi.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
          onPressed: () {
            modalBottomTypePassword(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
