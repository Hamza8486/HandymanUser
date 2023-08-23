import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

class AttachButton extends StatelessWidget {
  final Widget? text;
  final IconData? postfixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onTap;
  final bool? isPostfixIcon;
  final bool? isPrefixIcon;

  const AttachButton({Key? key,
    required this.onTap,
    this.text,
    this.prefixIcon,
    this.postfixIcon,
    this.isPostfixIcon = false,
    this.isPrefixIcon = false,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.blueColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isPrefixIcon == true ? Icon(prefixIcon, size: 16.0, color: AppColors.blackColor) : SizedBox(),
              const SizedBox(width: 3.0),
              text!,
              const SizedBox(width: 3.0),
              isPostfixIcon == true ? Icon(postfixIcon, color: AppColors.blackColor,
                size: 18.0,
              ) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
