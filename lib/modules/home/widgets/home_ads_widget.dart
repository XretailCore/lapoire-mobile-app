import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/components/custom_slider.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/lanaguages_enum.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/images_shimmer.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/theme.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

class HomeAdsWidget extends GetView<HomeController> {
  final List<ItemItem>? items;

  const HomeAdsWidget({Key? key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final language = Get.find<UserSharedPrefrenceController>().getLanguage;

    return Offstage(
      offstage: items == null || items!.isEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                controller.scrollController.previousPage();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: CustomThemes.appTheme.primaryColor,
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    language == Languages.ar.name
                        ? FontAwesomeIcons.caretRight
                        : FontAwesomeIcons.caretLeft,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustomSlider(
                ratio: 2,
                viewportFraction: 1.0,
                controller: controller.scrollController,
                showTitleAndButton: false,
                sliderImages: [
                  InkWell(
                    onTap: () => controller.goToListingWithId(
                      filterModel: items?[0].filterModel ?? FilterModel(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: items?[0].imageUrl ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    items?[0].imageUrl ?? "",
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, image) =>
                                const ImagesShimmerLoader(
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                items?[0].description ?? "sssssss",
                                style:
                                    const TextStyle(color: AppColors.redColor),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: CustomThemes.appTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  controller.goToListingWithId(
                                      filterModel: items?[0].filterModel ??
                                          FilterModel());
                                },
                                child: Text(
                                  Translate.shopNow.tr,
                                  style: TextStyle(
                                    fontSize: 16.sm,
                                    color: CustomThemes.appTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.goToListingWithId(
                      filterModel: items?[0].filterModel ?? FilterModel(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: items?[0].imageUrl ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    items?[0].imageUrl ?? "",
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, image) =>
                                const ImagesShimmerLoader(
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                items?[0].description ?? "sssssss",
                                style:
                                    const TextStyle(color: AppColors.redColor),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: CustomThemes.appTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  controller.goToListingWithId(
                                      filterModel: items?[0].filterModel ??
                                          FilterModel());
                                },
                                child: Text(
                                  Translate.shopNow.tr,
                                  style: TextStyle(
                                    fontSize: 16.sm,
                                    color: CustomThemes.appTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.goToListingWithId(
                      filterModel: items?[0].filterModel ?? FilterModel(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: items?[0].imageUrl ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  topLeft: Radius.circular(5),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    items?[0].imageUrl ?? "",
                                  ),
                                ),
                              ),
                            ),
                            placeholder: (context, image) =>
                                const ImagesShimmerLoader(
                              width: double.infinity,
                              height: 200,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                items?[0].description ?? "sssssss",
                                style:
                                    const TextStyle(color: AppColors.redColor),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      width: 2.0,
                                      color: CustomThemes.appTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  controller.goToListingWithId(
                                      filterModel: items?[0].filterModel ??
                                          FilterModel());
                                },
                                child: Text(
                                  Translate.shopNow.tr,
                                  style: TextStyle(
                                    fontSize: 16.sm,
                                    color: CustomThemes.appTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                controller.scrollController.nextPage();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: CustomThemes.appTheme.primaryColor,
                    shape: BoxShape.circle),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    language == Languages.ar.name
                        ? FontAwesomeIcons.caretLeft
                        : FontAwesomeIcons.caretRight,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Container(
//   padding: const EdgeInsets.all(5),
//   decoration: const BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.all(
//       Radius.circular(5),
//     ),
//   ),
//   child: Row(
//     children: [
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 5),
//           child: CustomText(
//             items?[0].name ?? "",
//             softWrap: true,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ),
//       // SizedBox(
//       //   width: 120,
//       //   child: CustomButton(
//       //     title: Translate.orderNow.tr,
//       //     color: CustomThemes.appTheme.primaryColor,
//       //     onTap: () => controller.goToListingWithId(
//       //       filterModel: items?[0].filterModel ?? FilterModel(),
//       //     ),
//       //   ),
//       // ),
//     ],
//   ),
// )
