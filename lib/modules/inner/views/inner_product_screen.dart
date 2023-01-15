import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/components/appbar_widget.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../controllers/inner_product_controller.dart';
import '../widgets/body_widget.dart';
import '../widgets/panel_widget.dart';

class InnerProductScreen extends GetView<InnerProductController> {
  const InnerProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!controller.comeFromRelated) {
          return true;
        } else {
          var isNavigate = controller.navigateRelated(context);
          return isNavigate;
        }
      },
      child: Scaffold(
        body: controller.obx(
          (product) {
            return Scaffold(
              appBar: InnerAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: controller.selectedProduct.title ?? ""),
              body: SlidingUpPanel(
                minHeight: Platform.isAndroid ? 50 : 65,
                maxHeight: 50,
                isDraggable: false,
                panelSnapping: false,
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                body: BodyWidget(
                  innerProductController: controller,
                  selectdProduct: product,
                  selectedSize: product?.sizes.firstWhere((element) =>
                      element?.id == product.selectedProductSku.sizeId),
                  selectedColor: product?.colors.firstWhere((element) =>
                      element?.id == product.selectedProductSku.colorId),
                  imagesUrl: product?.selectedProductSku.images
                          .map((image) => image?.url)
                          .toList() ??
                      [],
                ),
                panel: PanelWidget(
                  selectdProduct: product,
                ),
              ),
            );
          },
          onLoading: const CustomLoadingWidget(),
          onError: (e) => CustomErrorWidget(
            errorText: e,
            onReload: controller.onStartAction,
          ),
        ),
      ),
    );
  }
}
