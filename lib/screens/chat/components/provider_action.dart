import 'package:flutter/material.dart';

class ProviderAction extends StatelessWidget {
  final Color? borderColor;
  final Color? textColor;
  final IconData? iconData;
  final Color? iconColor;
  final String? text;
  final VoidCallback? onTap;

  const ProviderAction({Key? key,
    required this.onTap,
    this.text = 'Provider',
    this.textColor = Colors.green,
    this.iconData = Icons.check,
    this.borderColor = Colors.green,
    this.iconColor = Colors.green,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: borderColor!,
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(iconData, color: iconColor, size: 20.0),
            const SizedBox(width: 5.0),
            Text(text!,
              style: TextStyle(
                fontSize: 15.0,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
