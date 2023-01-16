import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../localization/translate.dart';

class CustomSlider extends StatelessWidget {
  final List<Widget> sliderImages;
  final CarouselController? controller;
  final bool showIndicator;
  final int pageIndex;
  final Color? indicatorColor;
  final Function(int value, CarouselPageChangedReason reason)? onPageChanged;
  final double ratio;

  const CustomSlider({
    Key? key,
    required this.sliderImages,
    this.controller,
    this.showIndicator = false,
    this.pageIndex = 0,
    this.indicatorColor,
    this.onPageChanged,
    this.ratio = 5 / 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          ///List of widget to show image
          items: sliderImages,
          options: CarouselOptions(
            enlargeCenterPage: false,
            onPageChanged: onPageChanged,
            viewportFraction: 2.0,
            initialPage: 0,
            aspectRatio: ratio,
            enableInfiniteScroll: sliderImages.length == 1 ? false : true,
            reverse: false,
            autoPlay: sliderImages.length == 1 ? false : true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeOutSine,
            // pauseAutoPlayOnTouch: Duration(seconds: 10),
          ),
          carouselController: controller,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  Translate.orderNow.tr,
                  style: TextStyle(
                      fontSize: 12.sm,
                      color: CustomThemes.appTheme.primaryColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Offstage(
                    offstage: !showIndicator || sliderImages.length == 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: sliderImages
                            .asMap()
                            .entries
                            .map(
                              (entry) => Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.fromLTRB(
                                    4.0,0.0,4.0,4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: CustomThemes.appTheme.primaryColor),
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? indicatorColor ?? Colors.white
                                          : indicatorColor ?? Colors.black)
                                      .withOpacity(
                                          pageIndex == entry.key ? 0.9 : 0.0),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
