import 'package:flutter/material.dart';
import 'package:pass_guard/presentation/components/text_custom.dart';

class ItemMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDisable;
  final double iconSize;
  final double textSize;

  const ItemMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDisable = false,
    this.iconSize = 24,
    this.textSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: isDisable ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: isDisable ? Colors.grey : Colors.white, size: iconSize),
            const SizedBox(height: 10.0),
            TextCustom(
              text: title,
              color: isDisable ? Colors.grey : Colors.white,
              fontSize: textSize,
              maxLines: 3,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
