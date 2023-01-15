import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    final primaryColor = Theme.of(context).primaryColor;
    return Wrap(
      children: selectdProduct?.sizes.map((e) {
            return InkWell(
              onTap: () {
                if (e?.id != null) {
                  innerProductController.onSizeChange(sizeId: e!.id!);
                }
              },
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isSelected(e) ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isSelected(e) ? primaryColor : Colors.grey,
                    width: 2,
                  ),
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
              ),
            );
          }).toList() ??
          <Widget>[],
    );
  }

  bool _isSelected(SizeModel? e) => selectedSize?.id == e?.id;
}
