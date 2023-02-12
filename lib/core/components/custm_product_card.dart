import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/inner/controllers/inner_product_controller.dart';
import '../utils/routes.dart';
import '../utils/strings.dart';
import 'custom_horizontal_card.dart';
import 'custom_vertical_card.dart';

class ProductCardWidget extends StatelessWidget {
  final Function()? onCardTap;
  final int productId;
  final double? elevation;
  final bool isHorizontal;
  final String image;
  final double imageHeight;
  final double? imageWidth;
  final String? brandName;
  final String productName;
  final double price;
  final double? oldPrice;
  final bool? hasOffer;
  final bool? showFavorite;
  final bool showDashedLine;
  final bool? isCart;
  final String? size;
  final String? color;
  final Color? cardColor;
  final int? count;
  final Function()? onIncrement;
  final Function()? onDecrement;
  final int? colorsCount;
  final Function()? onDelete;
  final Function()? onAddToCart;
  final bool isBogo;
  final double? rate;
  final String offerPercentage;
  final bool isAvailable;
  final int? maxCount;
  final String bogoText;
  final String promoText;
  final Function()? onAddFeedBack;
  final bool isPreOrder;
  final bool hideButtonsRow;

  const ProductCardWidget({
    Key? key,
    this.onCardTap,
    required this.productId,
    this.elevation,
    this.isHorizontal = false,
    required this.image,
    required this.imageHeight,
    this.imageWidth,
    this.brandName = "",
    required this.productName,
    required this.price,
    this.oldPrice,
    this.hasOffer = false,
    this.showFavorite = false,
    this.isCart = false,
    this.color = "",
    this.count,
    this.size = "",
    this.onIncrement,
    this.onDecrement,
    this.colorsCount,
    this.onDelete,
    this.onAddToCart,
    this.isBogo = false,
    this.rate,
    this.offerPercentage = "",
    this.isAvailable = true,
    this.maxCount,
    this.bogoText = '',
    this.promoText = '',
    this.onAddFeedBack,
    this.hideButtonsRow = false,
    this.isPreOrder = false,
    this.showDashedLine = false, this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap ??
          () {
            Get.toNamed(
              Routes.innerScreen,
              arguments: {
                Arguments.skuId: productId,
              },
            );
            final controller = Get.find<InnerProductController>();
            controller.onStartAction(isRelatedProduct: true, skuId: productId);
            controller.productsInQueue.add(productId);
            controller.comeFromRelated = true;
            if (isCart ?? false) controller.setCustomerChangedSize();
          },
      child: Card(
        color: cardColor??Colors.transparent,
        // ignore: prefer_if_null_operators
        elevation: elevation != null
            ? elevation
            : elevation == null && isHorizontal
                ? 2.5
                : 0,
        margin: const EdgeInsets.all(0),
        child: Visibility(
          visible: !isHorizontal,
          replacement: HorizontalProductCard(
            showDashedLine: showDashedLine,
            productId: productId,
            productName: productName,
            promoText: promoText,
            image: image,
            imageHeight: imageHeight,
            imageWidth: imageWidth,
            brandName: brandName,
            price: price,
            oldPrice: oldPrice,
            hasOffer: hasOffer,
            isCart: isCart,
            color: color!,
            count: count,
            showFavorite: showFavorite,
            size: size!,
            onIncrement: onIncrement,
            ondecrement: onDecrement,
            colorsCount: colorsCount,
            onDelete: onDelete,
            onAddToCart: onAddToCart,
            isBogo: isBogo,
            rate: rate,
            offerPercentage: offerPercentage,
            isAvailable: isAvailable,
            maxCount: maxCount,
            bogoText: bogoText,
          ),
          child: VerticalProductCard(
            onShowProductTap: onCardTap,
            productId: productId,
            productImage: image,
            promoText: promoText,
            hideButtonsRow: hideButtonsRow,
            isPreOrder: isPreOrder,
            itemSize: size ?? '',
            isCart: isCart ?? false,
            onDelete: onDelete,
            imageHeight: imageHeight,
            onAddToCart: onAddToCart,
            brandName: brandName,
            productName: productName,
            price: price,
            oldPrice: oldPrice,
            hasOffer: hasOffer,
            isBogo: isBogo,
            offerPercentage: offerPercentage,
            showFavorite: showFavorite,
            isAvailable: isAvailable,
            bogoText: bogoText,
            onAddFeedBack: onAddFeedBack,
            count: count ?? 1,
            onIncrement: onIncrement,
            onDecrement: onDecrement,
          ),
        ),
      ),
    );
  }
}
