import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/shimmer_loader/images_shimmer.dart';
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
    return Offstage(
      offstage: items == null || items!.isEmpty,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: InkWell(
          onTap: () => controller.goToListingWithId(
            filterModel: items?[0].filterModel ?? FilterModel(),
          ),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            elevation: 2,
            margin: const EdgeInsets.all(0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: items?[0].imageUrl ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200,
                    width: double.infinity,
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
                  placeholder: (context, image) => const ImagesShimmerLoader(
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CustomText(
                            items?[0].name ?? "",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: CustomButton(
                          title: Translate.orderNow.tr,
                          color: CustomThemes.appTheme.primaryColor,
                          onTap: () => controller.goToListingWithId(
                            filterModel: items?[0].filterModel ?? FilterModel(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
