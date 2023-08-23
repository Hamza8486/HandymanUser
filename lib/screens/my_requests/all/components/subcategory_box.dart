import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/bids/bids_screen.dart';
import 'package:user_apps/screens/my_requests/all/controllers/all_controller.dart';


class SubCategoryBox extends StatelessWidget {
  SubCategoryBox({Key? key}) : super(key: key);

  final AllController allController = Get.put(AllController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(BidsScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              blurRadius: 3.0,
              offset: const Offset(5.0, 0.0),
            ),
            BoxShadow(
              color: AppColors.greyColor.withOpacity(0.2),
              blurRadius: 3.0,
              offset: const Offset(0.0, 5.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Icon(Icons.image,
                        color: AppColors.greyColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Subcategory of request',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: AppColors.greyColor, size: 16.0),
                            SizedBox(width: 8.0),
                            Text('Address',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                      ],
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
                      child: Text('13',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Divider(
              color: AppColors.greyColor.withOpacity(0.6),
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text('Request Description',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: Text('Request Price',
                style: TextStyle(
                  fontSize: 15.0,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Divider(
              color: AppColors.greyColor.withOpacity(0.6),
              thickness: 1.0,
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  const SizedBox(width: 10.0),
                  const Text('Number of bids',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  /*const Icon(Icons.remove_red_eye,
                    color: AppColors.greyColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 6.0),
                  const Text('30',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: AppColors.greyColor,
                    ),
                  ),*/
                  const Icon(Icons.arrow_forward_ios, color: AppColors.greyColor, size: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
