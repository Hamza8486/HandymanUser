import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_apps/res/colors.dart';

import 'package:user_apps/widgets/Fonts/app_fonts.dart';

class BidBox extends StatelessWidget {
  final int? notifyCount;

  var image;
  var name;
  var reviews;
  var rating;
  var description;
  var price;
  final VoidCallback onTap;

  BidBox({
    Key? key,
    this.notifyCount = 2,
    this.name,
    this.image,
    this.price,
    required this.onTap,
    this.reviews,
    this.rating,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.blueColor),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(100),
                         child: CachedNetworkImage(
                           imageUrl:image??"", fit: BoxFit.cover,
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.orangeAccent, size: 16.0),
                              Text(
                                rating,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(Icons.chat_bubble,
                                  color: AppColors.greyColor, size: 16.0),
                              SizedBox(width: 4.0),
                              Text(
                                reviews,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              const Text(
                                'отзывов',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: AppColors.blackColor.withOpacity(0.7),
                              fontFamily: Weights.medium,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Divider(
                thickness: 0.7,
                color: AppColors.greyColor,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      "Бюджет: от ",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Text(
                      "${price} сом",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: Weights.semi,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 5.0),
              // const Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Text(
              //     'Provider offer price',
              //     style: TextStyle(
              //       fontSize: 15.0,
              //       color: AppColors.greyColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
