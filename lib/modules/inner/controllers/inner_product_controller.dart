import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../check_out/controllers/checkout_confirmation_controller.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:share/share.dart';
import '../../../core/components/custom_loaders.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/routes.dart';
import '../../../core/utils/strings.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../review/screens/add_review_dialog.dart';
import '../entities/product_entity.dart';
import '../widgets/details_buy_now_widget.dart';

enum ExpansionTileStatus {
  featuresAndBenefits,
  ingredientsAndHowToUse,
  reviews,
}

class InnerProductController extends GetxController
    with StateMixin<ProductEntity?> {
  int quantity = 1;
  RxInt pageIndex = 0.obs;
  bool isCustomerChangedSize = true;
  bool comeFromRelated = false;
  bool comeFromDeepLinking = false;

  final productsInQueue = <int>[].obs;
  final facebookAppEvents = FacebookAppEvents();

  InnerProductModel? product;
  ProductEntity selectedProduct = ProductEntity();
  bool? isAvailable = false;
  int? get _userId {
    final controller = Get.find<UserSharedPrefrenceController>();
    return controller.getUserId;
  }

  final Rx<ExpansionTileStatus?> _expansionTileStatus =
      Rx<ExpansionTileStatus?>(null);
  ExpansionTileStatus? get expansionTileStatus => _expansionTileStatus.value;
  set expansionTileStatus(ExpansionTileStatus? v) =>
      _expansionTileStatus.value = v;

  @override
  void onInit() {
    super.onInit();
    onStartAction();
  }

  void onStartAction({bool isRelatedProduct = false, int? skuId}) async {
    final arguments = (Get.arguments ?? {}) as Map;
    comeFromRelated = isRelatedProduct;

    int? productId =
        isRelatedProduct ? skuId : arguments[Arguments.skuId] as int?;

    selectedProduct.selectedProductSku =
        selectedProduct.selectedProductSku.copyWith(id: productId);

    if (selectedProduct.selectedProductSku.id != null) {
      _init(selectedProduct.selectedProductSku.id!);
    }
  }

  void updateIndex(int newIndex) {
    pageIndex.value = newIndex;
  }

  bool navigateRelated(BuildContext context) {
    Get.toNamed(
      Routes.innerScreen,
    );
    if (productsInQueue.length > 1) {
      productsInQueue.removeAt(productsInQueue.length - 1);
      onStartAction(
          isRelatedProduct: true,
          skuId: productsInQueue[productsInQueue.length - 1]);
      return false;
    } else if (comeFromDeepLinking) {
      Get.offAllNamed(Routes.dashboard);
      return false;
    } else {
      Navigator.of(context).pop();
      return true;
    }
  }

  Future<void> viewContentFBEvent() async {
    // facebookAppEvents.setAdvertiserTracking(enabled: true);
    facebookAppEvents.setAutoLogAppEventsEnabled(true);
    facebookAppEvents.logViewContent(
      id: selectedProduct.selectedProductSku.id.toString(),
      type: 'product',
      price: selectedProduct.selectedProductSku.finalPrice,
      currency: 'EGP',
    );
  }

  Future<void> addToWishlistFBEvent(ListingItem product) async {
    facebookAppEvents.logAddToWishlist(
      id: product.id.toString(),
      type: 'product',
      price: product.finalPrice!,
      currency: 'EGP',
    );
  }

  Future<void> addToCartFBEvent() async {
    facebookAppEvents.logAddToCart(
      id: selectedProduct.selectedProductSku.id.toString(),
      type: 'product',
      price: selectedProduct.selectedProductSku.finalPrice,
      currency: 'EGP',
    );
  }

  void onTapShareProduct(int? skuId) {
    Share.share('$websiteUrl/en/product/$skuId', subject: '');
  }

  int _initQuantity() => selectedProduct.selectedProductSku.isAvaliable ? 1 : 0;

  void _init(int selectdSkuId) async {
    try {
      change(null, status: RxStatus.loading());

      product = await _getProduct(selectdSkuId);
      change(selectedProduct, status: RxStatus.success());

      selectedProduct = _initProductEntity(product);
      final productSkus = product?.skus ?? [];
      final productSku = _selectSkuProduct(
          selectdSkuId: selectdSkuId, productSkus: productSkus);
      if (productSku != null) {
        selectedProduct.selectedProductSku = productSku;
        quantity = _initQuantity();
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<InnerProductModel?> _getProduct(int selectdSkuId) async {
    final product = await LinkTspApi.instance.sku.getProductDetails(
        skuid: selectdSkuId, customerId: _userId, version: 3);

    return product;
  }

  ProductEntity _initProductEntity(InnerProductModel? product) {
    return selectedProduct
      ..id = product?.id
      ..code = product?.code
      ..averageRating = product?.averageRating
      ..brandName = product?.brands?.name
      ..description = product?.description
      ..details = product?.details
      ..isAddedtoWishlist = product?.isAddedtoWishlist
      ..showOneClickOrder = product?.showOneClickOrder
      ..sizeGuide = product?.sizeGuide
      ..colors = product?.colors ?? []
      ..sizes = product?.sizes ?? []
      ..title = product?.title
      ..minDeliveryPeriod = product?.minDeliveryPeriod
      ..maxDeliveryPeriod = product?.maxDeliveryPeriod
      ..features = product?.features ?? []
      ..reviews = product?.review?.items ?? []
      ..bogoPromoText = product?.bogoPromoText
      ..categories = product?.categories ?? []
      ..recentItems = product?.recentItems ?? []
      ..relatedItems = product?.relatedItems ?? []
      ..promoText = product?.promoText
      ..preOrder = product?.preOrder ?? false
      ..isEnableAddReview = product?.isEnableAddReview ?? false
      ..availabilityDate = product?.availabilityDate
      ..periodName = product?.periodName
      ..deliveryNote = product?.deliveryNote;
  }

  SkuModel? _selectSkuProduct({
    int? selectdSkuId,
    required List<SkuModel?> productSkus,
  }) {
    if (_isAbleToSelectSkuProduct(selectdSkuId, productSkus)) {
      try {
        SkuModel? skuProduct = productSkus
            .firstWhere((skuProduct) => skuProduct?.id == selectdSkuId);
        return skuProduct;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return null;
  }

  bool isProductSkuAvaliable({int? sizeid, int? colorId}) {
    if (sizeid != null && colorId != null) {
      try {
        bool isAvaliable = product?.skus
                .firstWhere((skuProduct) =>
                    skuProduct?.colorId == colorId &&
                    skuProduct?.sizeId == sizeid)
                ?.isAvaliable ??
            false;

        return isAvaliable;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return false;
  }

  bool _isSelectedSkuIdNotNull(int? skuId) => skuId != null;

  bool _isAbleToSelectSkuProduct(
          int? selectedSkuId, List<SkuModel?> skuProducts) =>
      _isSelectedSkuIdNotNull(selectedSkuId) && skuProducts.isNotEmpty;

  void setCustomerChangedSize() => isCustomerChangedSize = true;

  void onSizeChange({required int sizeId}) {
    change(null, status: RxStatus.loading());

    setCustomerChangedSize();
    try {
      SkuModel? productSku = _selectSkuProductBySize(
          sizeId: sizeId, productSkus: product?.skus ?? []);
      if (productSku != null) {
        selectedProduct.selectedProductSku = productSku;
        isAvailable = isAvaliable();
        quantity = _initQuantity();
        viewContentFBEvent();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      change(selectedProduct, status: RxStatus.success());
    }
  }

  SkuModel? _selectSkuProductBySize(
      {required int sizeId,
      List<SkuModel?> productSkus = const <SkuModel?>[]}) {
    if (productSkus.isNotEmpty) {
      SkuModel? sku =
          productSkus.firstWhere((element) => element?.sizeId == sizeId);
      return sku;
    }
    return null;
  }

  void onColorChange(
      {required int selectedColorId, required List<ColorModel?> colors}) {
    change(null, status: RxStatus.loading());
    try {
      SkuModel? productSku = _selectSkuProductByColor(
          selectedColorId: selectedColorId, productSkus: product?.skus ?? []);
      if (productSku != null) {
        selectedProduct.selectedProductSku = productSku;
        quantity = _initQuantity();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      change(selectedProduct, status: RxStatus.success());
    }
  }

  SkuModel? _selectSkuProductByColor(
      {required int selectedColorId,
      List<SkuModel?> productSkus = const <SkuModel?>[]}) {
    if (productSkus.isNotEmpty) {
      SkuModel? sku = product?.skus
          .firstWhere((product) => product?.colorId == selectedColorId);
      quantity = _initQuantity();
      return sku;
    }
    return null;
  }

  void onTapAddReview(String? skuCode, BuildContext context) {
    final _userSharedPrefrenceController = UserSharedPrefrenceController();
    final isUser = _userSharedPrefrenceController.isUser;
    openAddReviewDialog(context,
        isUser: isUser, productCode: selectedProduct.code ?? '');
  }

  void onTapAllReviews(ProductEntity? data) {
    Get.toNamed(Routes.allReviewsScreen, arguments: {
      Arguments.productDetails: data,
    });
  }

  Future<void> onTapAddToCard(
      {required BuildContext context,
      required int? skuId,
      required double price,
      required int quantity}) async {
    final cartController = Get.find<CartController>();
    cartController.onTapAddToCard(
        isPreOrder: selectedProduct.preOrder,
        context: context,
        quantity: quantity,
        price: price,
        skuId: skuId!);
    addToCartFBEvent();
  }

  void _messageSelectSize() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        HelperFunctions.customSnackBar(
            message: Translate.pleaseSelectSize.tr,
            backgroundColor: Colors.red));
  }

  bool isNotHaveBogo() {
    return (selectedProduct.bogoPromoText?.isEmpty) ?? true;
  }

  bool isHaveDiscount() {
    return (selectedProduct.selectedProductSku.hasDiscount);
  }

  bool isNotHaveDiscount() => !isHaveDiscount();
  // bool _isNotVisibleReviews() => selectdProduct.reviewVisibility;

  bool get isPreBooking => selectedProduct.preOrder;

  bool isShowBuyNow() => (selectedProduct.showOneClickOrder ?? false);

  bool isAvaliable() =>
      selectedProduct.selectedProductSku.maxQuantity > 0 &&
      selectedProduct.selectedProductSku.isAvaliable;

  Future<void> onTapBuyNow(BuildContext context,
      {required int? skuid, required int qty}) async {
    if (isCustomerChangedSize) {
      if (_userId != null) {
        openLoadingDialog(context);
        try {
          final details = await LinkTspApi.instance.checkOut
              .oneClickOrderDetails(
                  customerId: _userId!, qty: qty, skuId: skuid!);
          Get.back();
          await _showConfirmDialog(details, context, qty, skuid);
        } catch (e) {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(
              HelperFunctions.customSnackBar(
                  message: e.toString(), backgroundColor: Colors.red));
        }
      } else {
        await Get.toNamed(Routes.sign);
      }
    } else {
      _messageSelectSize();
    }
  }

  Future<void> _showConfirmDialog(OneClickOrderDetailsModel? details,
      BuildContext context, int qty, int skuid) async {
    await Get.dialog(
      DetailsBuyNowWidget(
        details: details,
        onTap: () async {
          Get.back();
          openLoadingDialog(context);
          try {
            final orderCode =
                await LinkTspApi.instance.checkOut.confirmOneClickOrder(
              customerId: _userId!,
              qty: qty,
              skuId: skuid,
              addressId: details?.addressId,
            );
            Get.back();
            final checkoutConfirmationController =
                Get.find<CheckoutConfirmationController>();
            checkoutConfirmationController.orderCode = orderCode;
            Get.offAndToNamed(Routes.checkoutConfirmationScreen);
          } on ExceptionApi catch (e) {
            Get.back();
            ScaffoldMessenger.of(context).showSnackBar(
                HelperFunctions.customSnackBar(
                    message: e.message, backgroundColor: Colors.red));
          } catch (e) {
            Get.back();
            ScaffoldMessenger.of(Get.context!).showSnackBar(
                HelperFunctions.customSnackBar(
                    message: e.toString(), backgroundColor: Colors.red));
          }
        },
      ),
    );
  }

  @override
  void onClose() {
    _expansionTileStatus.close();
    super.onClose();
  }
}
