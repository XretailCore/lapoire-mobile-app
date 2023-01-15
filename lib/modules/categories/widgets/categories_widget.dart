import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/shimmer_loader/images_shimmer.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';
import '../controllers/categories_controller.dart';

class CategoriesWidgets extends GetView<CategoriesController> {
  final String image;
  final String title;
  final int index;
  final VoidCallback onTap;
  const CategoriesWidgets({
    Key? key,
    required this.image,
    required this.title,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.highlighter,
              border: Border.all(
                color: AppColors.highlighter,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
               const SizedBox(width: 24.0),
                image.isNotEmpty
                    ? ExtendedImage.network(
                        image,
                        height: 70,
                        width: 70,
                        cacheHeight: 800,
                        enableMemoryCache: false,
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.high,
                        clearMemoryCacheWhenDispose: true,
                        enableLoadState: false,
                        enableSlideOutPage: true,
                      )
                    : Center(
                        child: Image.asset(
                          'assets/images/main_logo.png',
                          width: 100,
                        ),
                      ),
                const SizedBox(width: 24.0),
                Expanded(
                  child: CustomText(
                    title,
                    textAlign: TextAlign.start,
                    style:  TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
