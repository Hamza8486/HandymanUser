import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatelessWidget {
  final double height;
  final double width;
  final double aspectRatio;
  final double radius;
  final List imageList;
  final int autoPlayInterval;
  final int autoPlayAnimationDuration;
  final bool autoPlay;
  final bool isCover;
  final bool pauseAutoPlayInFiniteScroll;

  const AppSlider({
    this.isCover = true,
    Key? key,
    this.height = 120,
    this.aspectRatio = 16 / 9,
    this.width = 150,
    this.autoPlayInterval = 2,
    required this.imageList,
    this.autoPlayAnimationDuration = 800,
    this.autoPlay = true,
    this.pauseAutoPlayInFiniteScroll = false,
    this.radius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        aspectRatio: aspectRatio,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        pauseAutoPlayInFiniteScroll: pauseAutoPlayInFiniteScroll,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: autoPlayInterval),
        autoPlayAnimationDuration:
        Duration(milliseconds: autoPlayAnimationDuration),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: imageList
          .map(
            (item) => ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            item.image,
            fit: isCover ? BoxFit.fill : null,
            width: double.infinity,
          ),
        ),
      )
          .toList(),
    );
  }
}
