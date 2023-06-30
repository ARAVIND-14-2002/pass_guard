import 'package:flutter/material.dart';
import 'package:pass_guard/presentation/components/components.dart';
import 'package:pass_guard/presentation/themes/themes.dart';

void modalMessage(BuildContext context, String message, {Color? color}){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) 
      => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Row(
                  children: [
                    Icon(Icons.info_rounded, color: Colors.white, size: 30),
                    SizedBox(width: 10.0),
                    TextCustom(text: 'Pass Guard', isTitle: true, fontWeight: FontWeight.w600,color: Colors.white,)
                  ],
                ),
                const SizedBox(height: 20.0),
                TextCustom(text: message, fontSize: 17, fontWeight: FontWeight.w400, textAlign: TextAlign.left),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: ColorsArvi.primary
              ),
              onPressed: () => Navigator.pop(context), 
              child: const TextCustom(text: 'Ok', color: ColorsArvi.primary, fontWeight: FontWeight.w500,)
            )
          ],
      ),
  );
}