import 'package:linktsp_api/linktsp_api.dart' hide Product;

class ProductEntity {
  int? id;
  String? code;
  SkuModel selectedProductSku;
  String? brandName;
  String? title;
  double? averageRating;
  List<ColorModel?> colors;
  List<SizeModel?> sizes;
  String? details;
  String? description, bogoPromoText;
  String? sizeGuide;
  bool? showOneClickOrder;
  bool? isAddedtoWishlist;
  int? minDeliveryPeriod, maxDeliveryPeriod;
  String? periodName, deliveryNote;

  List<FeatureModel?> features;
  List<ItemReviewModel> reviews;
  List<CategoryModel> categories;
  List<ProductModel> recentItems, relatedItems;
  String? promoText;
  bool preOrder;
  bool isEnableAddReview;
  DateTime? availabilityDate;
  ProductEntity({
    this.id,
    this.code,
    this.selectedProductSku = const SkuModel(),
    this.brandName,
    this.title,
    this.averageRating,
    this.colors = const <ColorModel?>[],
    this.sizes = const <SizeModel?>[],
    this.details,
    this.description,
    this.bogoPromoText,
    this.isAddedtoWishlist,
    this.showOneClickOrder,
    this.sizeGuide,
    this.minDeliveryPeriod,
    this.maxDeliveryPeriod,
    this.deliveryNote,
    this.features = const <FeatureModel?>[],
    this.reviews = const <ItemReviewModel>[],
    this.categories = const <CategoryModel>[],
    this.recentItems = const <ProductModel>[],
    this.relatedItems = const <ProductModel>[],
    this.promoText,
    this.preOrder = false,
    this.isEnableAddReview = false,
    this.availabilityDate,
    this.periodName,
  });
}
