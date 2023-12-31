import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_guard/presentation/components/components.dart';

class ItemModalSetting extends StatelessWidget {

  final String text;
  final IconData icon;
  final Function() onTap;
  final bool isVersion;

  const ItemModalSetting({
    Key? key, 
    required this.text, 
    required this.icon, 
    required this.onTap,
    this.isVersion = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.white)
                ),
                child: Icon(icon, size: 16, color: Theme.of(context).iconTheme.color)
              ),
              const SizedBox(width: 10.0),
              TextCustom(
                text: text,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
          isVersion
          ? const TextCustom(
              text: 'v1.0.0',
              color: Colors.grey,
              fontSize: 14,
            )
          : Icon(FontAwesomeIcons.anglesRight, size: 19.0, color: Theme.of(context).iconTheme.color)
        ],
      ),
    );
  }
}