import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/res/images.dart';


class JobPost extends StatelessWidget {
  final double? width;
  final int? jobPrice;
  final String? address;
  final String? jobDesc;
  final bool? isAttachImage;
  final String? userName;
  final VoidCallback? onChat;

  const JobPost({Key? key,
    required this.onChat,
    this.width,
    this.jobPrice = 150000,
    this.address = 'Street Address',
    this.jobDesc = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    required this.isAttachImage,
    this.userName = 'Henry Kamal',
}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.3),
            blurRadius: 3.0,
            offset: const Offset(5.0, 0.0),
          ),
          BoxShadow(
            color: AppColors.greyColor.withOpacity(0.3),
            blurRadius: 3.0,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$jobPrice сом',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                height: 20.0,
                width: 20.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.redColor,
                ),
                child: const Center(
                  child: Text('1',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, color: AppColors.greyColor, size: 16.0),
              const SizedBox(width: 10.0),
              Text(address!,
                style: const TextStyle(
                  fontSize: 13.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(jobDesc!,
            style: const TextStyle(
              fontSize: 14.0,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isAttachImage == true ? 16.0 : 0.0),
          isAttachImage == true ? SizedBox(
            height: 70.0,
            width: 70.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(AppImages.personImage),
            ),
          ) : const SizedBox(),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(AppImages.personImage),
              ),
              const SizedBox(width: 8.0),
              Text(userName!,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),

              IconButton(
                onPressed: onChat,
                icon: const Icon(Icons.chat, color: AppColors.redColor, size: 20.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
