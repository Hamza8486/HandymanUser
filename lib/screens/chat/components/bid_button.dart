import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

class BidButton extends StatelessWidget {
  final IconData? iconData;
  final String? text;
  final Color? textColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const BidButton({Key? key,
    this.iconData = Icons.person_pin,
    this.iconColor = AppColors.blueColor,
    this.text = 'Text Here',
    this.textColor = AppColors.blueColor,
    required this.onTap,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: iconColor),
            SizedBox(width: 5.0),
            Text(text!,
              style: TextStyle(
                fontSize: 15.0,
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
