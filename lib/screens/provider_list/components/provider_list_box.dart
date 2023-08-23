// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/Services/helper_function.dart';
import 'package:user_apps/res/colors.dart';
import 'package:user_apps/screens/BottomTabsView/home/controllers/home_controller.dart';
import 'package:user_apps/screens/provider_detail/provider_detail_screen.dart';
import 'package:user_apps/screens/provider_list/controller/provider_list_controller.dart';
import 'package:user_apps/widgets/AppDimensions/app_dimensions.dart';
import 'package:user_apps/widgets/Fonts/app_fonts.dart';




class ProviderListView extends StatelessWidget {
   ProviderListView({Key? key}) : super(key: key);

  final providerController = Get.put(ProviderListController());

  @override
  Widget build(BuildContext context) {
    return
      Obx(
      () {
          return
            providerController.providerList.isNotEmpty
                ?
            ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              shrinkWrap: true,
              primary: false,
              itemCount: providerController.providerList.length,
              itemBuilder: (context, index){
                return  GestureDetector(
                  onTap: (){

                    providerController.updateSubId(providerController.providerList[index].id);
                    Get.put(HomeController()).updateProvider(providerController.providerList[index].id.toString());
                    Get.to(

                        ProviderDetailScreen(data: providerController.providerList[index],));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
                    padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100.0),

                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          imageUrl:providerController.providerList[index].image, fit: BoxFit.cover,
                                          errorWidget:(context, url, error) => ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.asset(
                                                'assets/images/person.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                          placeholder: (context, url) =>


                                          const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.blueColor,
                                              )),



                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5.0),
                                        Text("${providerController.providerList[index].firstName}",
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color: AppColors.blackColor,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:  [
                                            Icon(Icons.star, color: Colors.orangeAccent, size: 16.0),
                                            Text(providerController.providerList[index].avgRating.toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Icon(Icons.chat_bubble, color: AppColors.greyColor, size: 16.0),
                                            SizedBox(width: 4.0),
                                            Text(providerController.providerList[index].ratingCount.toString(),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 6.0),
                                            Text('отзывов',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Divider(
                          thickness: 0.7,
                          color: AppColors.greyColor,
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(providerController.providerList[index].aboutMe,
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.blackColor,

                              fontFamily: Weights.semi,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        ListView.builder(
                          shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemCount: providerController.providerList[index].service.length,
                            itemBuilder: (BuildContext context, int i) {
                              return  Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                                child: Row(
                                  children: [
                                    Text(providerController.providerList[index].service[i].name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize:AppSizes.SIZE_13,
                                        color: AppColors.blackColor.withOpacity(0.6),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),

                                    ),
                                    SizedBox(width: Get.width*0.03,),
                                    Expanded(
                                      child: MySeparator(color: AppColors.blackColor.withOpacity(0.6),),
                                    ),
                                    SizedBox(width: Get.width*0.03,),
                                    Text("от ${providerController.providerList[index].service[i].price.toString().split(".").first
                                    } сом",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize:AppSizes.SIZE_12,
                                        color: AppColors.blackColor.withOpacity(0.6),
                                        fontFamily: Weights.semi,

                                        fontWeight: FontWeight.w500,
                                      ),

                                    ),

                                  ],
                                ),
                              );
                            }),
                        const SizedBox(height: 8.0),
                        Obx(
                          () {
                            return
                              providerController.providerList[index].portfolio.isEmpty?SizedBox.shrink():
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                height: Get.height*0.1,
                                child: ListView.builder(
                                    itemCount: providerController.providerList[index].portfolio.length,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int ind) {
                                      return Container(


                                        margin: EdgeInsets.symmetric(horizontal:Get.width*0.02,vertical: 5),
                                        width: Get.height*0.1,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl:providerController.providerList[index].portfolio[ind].image, fit: BoxFit.cover,
                                            errorWidget:(context, url, error) => ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.asset(
                                                  'assets/images/person.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            placeholder: (context, url) =>


                                            const Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.blueColor,
                                                )),



                                          ),
                                        ),

                                      );
                                    }),
                            ),
                              );
                          }
                        ),


                      ],
                    ),
                  ),
                );
              }):noData();
        }
      );


  }


}


class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
