import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

class RequestSheetButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? titleText;
  final IconData? leadingIcon;
  final Color? textColor;
  final Color? iconColor;

  const RequestSheetButton({Key? key,
    required this.onPressed,
    this.titleText = 'Изменить заявку',
    this.leadingIcon = Icons.edit,
    this.textColor = AppColors.blackColor,
    this.iconColor = AppColors.greyColor,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(leadingIcon, color: iconColor),
      trailing: IconButton(onPressed: (){},
        icon: const Icon(Icons.arrow_forward_ios, size: 16.0, color: AppColors.greyColor),
      ),
      title: Text(titleText!,
        style:  TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
