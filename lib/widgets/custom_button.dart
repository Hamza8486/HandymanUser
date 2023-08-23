import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? btnColor;
  final String? btnText;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;
  final Color? textColor;

  const CustomButton({Key? key,
    required this.onTap,
    this.width,
    this.height = 55.0,
    this.btnColor = AppColors.redColor,
    this.btnText = 'Button Text',
    this.borderColor = AppColors.backColor,
    this.borderWidth = 0.0,
    this.textColor = Colors.white,
}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size?>(
          Size(width!, height!),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(
          btnColor,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: borderColor!,
              width: borderWidth!,
            ),
          ),
        ),
      ),
      child: Text(btnText!,
        style: TextStyle(
          fontSize: 16.0,
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
