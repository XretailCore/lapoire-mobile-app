import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/data/list/models/list_model.dart';
import 'package:linktsp_api/data/page_block/models/new_page_block_model.dart';

import '../../modules/inner/widgets/favoriate_button_widget.dart';
import '../../modules/wishlist/controllers/wishlist_controller.dart';
import '../utils/routes.dart';
import '../utils/strings.dart';
import '../utils/theme.dart';

class ProductButtonsWidget extends StatefulWidget {
  final ItemItem product;
  final Function()? onAddToCart;
  const ProductButtonsWidget(
      {Key? key, required this.product, required this.onAddToCart})
      : super(key: key);

  @override
  State<ProductButtonsWidget> createState() => _ProductButtonsWidgetState();
}

class _ProductButtonsWidgetState extends State<ProductButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    var primaryColor = CustomThemes.appTheme.primaryColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          highlightColor: AppColors.highlighter,
          customBorder: const CircleBorder(),
          onTap: () {
            Get.toNamed(
              Routes.innerScreen,
              arguments: {
                Arguments.skuId: widget.product.id,
              },
            );
          },
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    FaIcon(FontAwesomeIcons.eye, size: 15, color: primaryColor),
              ),
            ),
          ),
        ),
        Obx(
          () => Container(
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FavoriateButtonWidget(
                key: UniqueKey(),
                iconSize: 15,
                defaultValue: Get.find<WishlistController>()
                    .isFavorite(widget.product.id ?? 0),
                onFavoraite: (v) {
                  var listingItem = ListingItem(
                    id: widget.product.id,
                    finalPrice: widget.product.product?.finalPrice,
                  );
                  final wishlistController = Get.find<WishlistController>();
                  wishlistController.onChangeFavorite(context, v, listingItem);
                },
              ),
            ),
          ),
        ),
        InkWell(
          highlightColor: AppColors.highlighter,
          customBorder: const CircleBorder(),
          onTap: !(widget.product.product?.isOutOfStock ?? false)
              ? widget.onAddToCart
              : null,
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: primaryColor),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(FontAwesomeIcons.cartShopping,
                    size: 15, color: primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
