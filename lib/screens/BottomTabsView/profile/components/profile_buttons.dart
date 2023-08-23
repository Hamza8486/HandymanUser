import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

class ProfileButtons extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData? icon;
  final String? title;

  const ProfileButtons({Key? key,
    required this.onTap,
    this.icon = Icons.location_on,
    this.title = 'Title',
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 16.0),
            Icon(icon,
                color: AppColors.greyColor),
            const SizedBox(width: 16.0),
            Text(title!,
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
