import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/presentation/components/animation_route.dart';
import 'package:pass_guard/presentation/screens/card/add_card_screen.dart';
import 'package:pass_guard/presentation/screens/home/components/item_option_type.dart';
import 'package:pass_guard/presentation/screens/notepad/notepad_home_screen.dart';
import 'package:pass_guard/presentation/screens/passwords/modal_add_password_home.dart';

void modalBottomTypePassword(BuildContext context) {

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 170,
      margin: const EdgeInsets.only(left: 0, right: 0),
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white70
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: [                  
                  ItemOptionType(
                    onTap: () {
                      Navigator.pop(context);
                      modalAddPasswordHome(context);
                    },
                    icon: const Icon(FontAwesomeIcons.key, size: 17, color: Colors.purple),
                    title: 'New Password',
                  ),
                  const Divider(height: 1),
                  ItemOptionType(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, routeFade(page: const AddCardScreen()));
                    },
                    icon: const Icon(FontAwesomeIcons.creditCard, size: 17, color: Colors.orange),
                    title: 'New Card',
                  ),
                  // const Divider(height: 1),
                  // ItemOptionType(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     Navigator.push(context, routeFade(page: const NotepadHomeScreen()));
                  //   },
                  //   icon: const Icon(FontAwesomeIcons.fileLines, size: 17, color: Colors.green),
                  //   title: 'Notepad',
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );


}