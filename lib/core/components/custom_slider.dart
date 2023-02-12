import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/core/utils/theme.dart';

class CustomSlider extends StatefulWidget {
  final List<Widget> sliderImages;
  final CarouselController? controller;
  final bool showIndicator;
  final int pageIndex;
  final bool isInner;
  final bool showTitleAndButton;
  final double? viewportFraction;
  final bool? autoPlay;
  final Color? indicatorColor;
  final Function(int value, CarouselPageChangedReason reason)? onPageChanged;
  final double ratio;
  final double? height;

  const CustomSlider(
      {Key? key,
      required this.sliderImages,
      this.controller,
      this.showIndicator = false,
      this.pageIndex = 0,
      this.indicatorColor,
      this.onPageChanged,
      this.ratio = 0.8,
      this.showTitleAndButton = true,
      this.isInner = false,
      this.viewportFraction,
      this.autoPlay,
      this.height})
      : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: widget.sliderImages,
          options: CarouselOptions(
              enlargeCenterPage: false,
              onPageChanged: widget.onPageChanged,
              viewportFraction: widget.viewportFraction ?? 2.0,
              initialPage: 0,
              aspectRatio: widget.ratio,
              enableInfiniteScroll:
                  widget.sliderImages.length == 1 ? false : true,
              reverse: false,
              autoPlay: widget.autoPlay != null
                  ? widget.autoPlay!
                  : widget.sliderImages.length == 1
                      ? false
                      : true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeOutSine,
              height: widget.height),
          carouselController: widget.controller,
        ),
        Positioned(
          bottom: 10,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Offstage(
                    offstage: !widget.showIndicator ||
                        widget.sliderImages.length == 1,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.sliderImages
                            .asMap()
                            .entries
                            .map(
                              (entry) => SizedBox(
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: const EdgeInsets.fromLTRB(
                                      4.0, 0.0, 4.0, 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: widget.isInner
                                            ? AppColors.redColor
                                            : CustomThemes
                                                .appTheme.primaryColor),
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? widget.indicatorColor ??
                                                Colors.white
                                            : widget.indicatorColor ??
                                                Colors.black)
                                        .withOpacity(
                                            widget.pageIndex == entry.key
                                                ? 0.9
                                                : 0.0),
                                  ),
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
