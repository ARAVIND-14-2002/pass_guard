import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/home/components/card_password.dart';
import 'package:pass_guard/presentation/screens/passwords/modal_add_password_home.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

class AppPasswordScreen extends StatefulWidget {

  const AppPasswordScreen({Key? key}) : super(key: key);

  @override
  State<AppPasswordScreen> createState() => _AppPasswordScreenState();
}

class _AppPasswordScreenState extends State<AppPasswordScreen> {

  late TextEditingController _searchController;
  late HomeBloc homeBloc;

  @override
  void initState() {
    _searchController = TextEditingController();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Aplications',
          isTitle: true,
          color: Color(4294309367),
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            homeBloc.add(ClearSearchAppPasswordEvent());
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19.0)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: TextFormField(
                  controller: _searchController,
                  style: GoogleFonts.poppins(fontSize: 15.0, fontWeight: FontWeight.w600, color: ColorsArvi.primary),
                  cursorColor: ColorsArvi.primary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search password',
                    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 17.0, color: Colors.grey),
                    hintStyle: GoogleFonts.poppins(color: Colors.grey)
                  ),
                  onChanged: (value) {
                    homeBloc.add(ClearSearchAppPasswordEvent());
                    if(value.isNotEmpty){
                      homeBloc.add(SearchAppPasswordEvent(value));
                    }
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {

                    if(state.passwordApp.isEmpty){
                      return const Center(
                        child: TextCustom(
                          text: 'No Passwords to Display',
                          isTitle: true,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    return state.searchPasswordApp.isEmpty && _searchController.text.trim().isEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.passwordApp.length,
                        itemBuilder: (context, i) {
                          return CardPassword(password: state.passwordApp[i], index: i);
                        },
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.searchPasswordApp.length,
                        itemBuilder: (context, i) {
                          return CardPassword(password: state.searchPasswordApp[i], index: i);
                        },
                      );
                  },
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add-password',
        backgroundColor: ColorsArvi.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
        ),
        child: const Icon(FontAwesomeIcons.plus,color: Colors.white,),
        onPressed: (){
          modalAddPasswordHome(context);
        }
      ),
    );
  }
}