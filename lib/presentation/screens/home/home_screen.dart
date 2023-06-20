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
                            color: const Color(0xffB288F7),
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
                            color: const Color(0xff2D9E2D),
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
                            subtitle: '${state.cardStadistcs} cards',
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
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: ColorsFrave.primary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.home,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 200),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ImportExport()),
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.download,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'add-password',
          backgroundColor: ColorsFrave.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
          onPressed: () {
            modalBottomTypePassword(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
