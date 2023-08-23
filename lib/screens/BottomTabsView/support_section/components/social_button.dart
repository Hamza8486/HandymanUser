import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  final String? btnText;
  final Color? borderColor;
  final String? iconPath;
  final VoidCallback? onTap;

  const SocialButton({Key? key,
    required this.onTap,
    this.btnText = 'Text',
    this.borderColor = Colors.green,
    this.iconPath,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 32.0, top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: borderColor!,
              width: 2.0,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(iconPath!),
              const SizedBox(width: 16.0),
              Text(btnText!,
                style: TextStyle(
                  fontSize: 18.0,
                  color: borderColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
