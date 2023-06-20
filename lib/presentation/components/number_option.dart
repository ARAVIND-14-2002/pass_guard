import 'package:flutter/material.dart';
import 'package:pass_guard/presentation/components/components.dart';

class NumberOption extends StatelessWidget {

  final String text;
  final Function() onTap;

  const NumberOption({
    Key? key, 
    required this.text, 
    required this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(70.0),
        onTap: onTap,
        child: Ink(
          height: 60,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            shape: BoxShape.circle
          ),
          child: Center(
            child: TextCustom(
              text: text,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }
}