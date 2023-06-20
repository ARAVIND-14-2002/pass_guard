import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_guard/domain/blocs/blocs.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/screens/home/components/card_password.dart';

class RecentrlyAdded extends StatelessWidget {

  const RecentrlyAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        if(state.passwordRecently.isEmpty){
          return const Center(
            child: TextCustom(
              text: 'Mate, its safe here!',
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              isTitle: true,
            ),
          );
        }

        return ListView.builder(
          itemCount: state.passwordRecently.length > 10 ? 10 : state.passwordRecently.length,
          itemBuilder: (context, i) {
            
            final password = state.passwordRecently[i];

            return CardPassword(password: password, index: i);
          },
        );
      },
    );
  }
}