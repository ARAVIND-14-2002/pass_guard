import 'package:flutter/material.dart';
import 'package:pass_guard/presentation/components/text_custom.dart';

class ItemMenu extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;
  final bool isDisable;
  final double iconSize;
  final double textSize;
  final bool enableSlideToUnlock;

  const ItemMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDisable = false,
    this.iconSize = 30,
    this.textSize = 20,
    this.enableSlideToUnlock = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (enableSlideToUnlock) {
      return _buildSlideToUnlockItemMenu();
    } else {
      return _buildRegularItemMenu();
    }
  }

  Widget _buildRegularItemMenu() {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      // splashColor: Colors.white,
      // highlightColor: Colors.white,
      onTap: isDisable ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 120, // Adjust the width as desired
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: isDisable ? Colors.grey : Colors.white, size: iconSize),
                  const SizedBox(width: 20.0), // Increase the width as desired
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
          ],
        ),
      ),
    );
  }

  Widget _buildSlideToUnlockItemMenu() {
    return GestureDetector(
      onPanStart: (details) {},
      onPanUpdate: (details) {},
      onPanEnd: (_) {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: 120, // Adjust the width as desired
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: iconSize),
                  const SizedBox(width: 20.0), // Increase the width as desired
                  TextCustom(
                    text: title,
                    color: Colors.white,
                    fontSize: textSize,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

