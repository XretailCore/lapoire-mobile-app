import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_text.dart';
import '../controllers/inner_product_controller.dart';
import '../entities/product_entity.dart';

class SelectSizeWidget extends GetView<InnerProductController> {
  const SelectSizeWidget({
    Key? key,
    this.selectdProduct,
    required this.innerProductController,
    this.selectedSize,
  }) : super(key: key);

  final ProductEntity? selectdProduct;
  final InnerProductController innerProductController;
  final SizeModel? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: selectdProduct?.sizes.map((e) {
            var child = Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: _isSelected(e) ? AppColors.redColor : AppColors.redColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: CustomText(
                e?.name ?? '',
                style: TextStyle(
                  fontSize: 9,
                  color: _isSelected(e) ? Colors.white : null,
                  fontWeight: FontWeight.bold,
                  decoration: _isSelected(e) &&
                          !controller.isAvaliable() &&
                          (selectdProduct?.sizes.length ?? 0) > 1
                      ? TextDecoration.lineThrough
                      : null,
                  decorationColor: Colors.red,
                  decorationThickness: 2,
                ),
              ),
            );
            return InkWell(
              onTap: () {
                if (e?.id != null) {
                  innerProductController.onSizeChange(sizeId: e!.id!);
                }
              },
              child: _isSelected(e)
                  ? child
                  : DottedBorder(
                      padding: EdgeInsets.zero,
                      radius: const Radius.circular(18),
                      color: AppColors.redColor,
                      borderType: BorderType.RRect,
                      child: child,
                    ),
            );
          }).toList() ??
          <Widget>[],
    );
  }

  bool _isSelected(SizeModel? e) => selectedSize?.id == e?.id;
}
