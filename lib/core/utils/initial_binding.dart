import 'package:get/get.dart';
import '../../modules/check_out/controllers/store_location_controller.dart';
import '../../modules/content/controllers/pre_booking_policy_controller.dart';
import '../../modules/dashboard/controller/dashboard_controller.dart';
import '../../modules/my_account/controllers/my_account_controller.dart';
import '../../modules/search/controller/search_controller.dart';
import '../../modules/select_location_from_map/controllers/select_location_from_map_controller.dart';
import '../../modules/wishlist/controllers/wishlist_controller.dart';
import '../../modules/address_details/controllers/address_details_controller.dart';
import '../../modules/review/controllers/all_reviews_controller.dart';
import '../../modules/auth/controllers/change_password_controller.dart';
import '../../modules/auth/controllers/forget_password_controller.dart';
import '../../modules/auth/controllers/new_password_controller.dart';
import '../../modules/auth/controllers/profile_controller.dart';
import '../../modules/auth/controllers/signin_controller.dart';
import '../../modules/auth/controllers/signup_controller.dart';
import '../../modules/auth/controllers/terms_of_service_controller.dart';
import '../../modules/auth/controllers/verify_otp_controller.dart';
import '../../modules/auth/controllers/verify_otp_forget_password_controller.dart';
import '../../modules/cart/controllers/cart_controller.dart';
import '../../modules/categories/controllers/categories_controller.dart';
import '../../modules/check_out/controllers/checkout_confirmation_controller.dart';
import '../../modules/check_out/controllers/credit_card_controller.dart';
import '../../modules/check_out/controllers/customer_location_controller.dart';
import '../../modules/check_out/controllers/customer_summary_controller.dart';
import '../../modules/check_out/controllers/delivery_controller.dart';
import '../../modules/check_out/controllers/payment_controller.dart';
import '../../modules/check_out/controllers/shipping_information_controller.dart';
import '../../modules/choose_zone/controllers/choose_zone_controller.dart';
import '../../modules/contact_us/controllers/contact_us_controller.dart';
import '../../modules/content/controllers/content_controller.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../modules/inner/controllers/inner_product_controller.dart';
import '../../modules/intro/controllers/intro_controller.dart';
import '../../modules/listing_items/controllers/filter_controller.dart';
import '../../modules/listing_items/controllers/listing_controller.dart';
import '../../modules/map/controllers/map_controller.dart';
import '../../modules/my_addresses/controller/my_addresses_controller.dart';
import '../../modules/my_orders/controller/my_orders_controller.dart';
import '../../modules/order_details/controllers/cancel_order_controller.dart';
import '../../modules/order_details/controllers/feedback_order_controller.dart';
import '../../modules/order_details/controllers/order_details_controller.dart';
import '../../modules/order_track/controllers/track_order_controller.dart';
import '../../modules/review/controllers/add_review_controller.dart';
import '../../modules/settings/controller/language_controller.dart';
import '../../modules/settings/controller/settings_controller.dart';
import '../../modules/settings/controller/subscribe_controller.dart';
import '../../modules/splash/controllers/splash_controller.dart';
import '../../modules/stores/controllers/stores_controller.dart';
import 'custom_shared_prefrenece.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Put
    Get.put(UserSharedPrefrenceController());
    Get.put(CartController());
    Get.put(WishlistController());

    Get.put(MyAccountController());

    // Lazy put
    Get.lazyPut(() => CheckoutConfirmationController(), fenix: true);

    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => IntroController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => CategoriesController(), fenix: true);
    Get.lazyPut(() => SigninController(), fenix: true);
    Get.lazyPut(() => SignupController(), fenix: true);
    Get.lazyPut(() => VerifyOtpController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);
    Get.lazyPut(() => StoreLocationController(), fenix: true);
    Get.lazyPut(() => ListItemsController(), fenix: true);
    Get.lazyPut(() => FilterController(), fenix: true);
    Get.lazyPut(() => ContentPagesController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => MyOrdersController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => MyAddressesController(), fenix: true);
    Get.lazyPut(() => OrderDetailsController(), fenix: true);
    Get.lazyPut(() => CancelOrderController(), fenix: true);
    Get.lazyPut(() => FeedbackOrderController(), fenix: true);
    Get.lazyPut(() => TrackOrderController(), fenix: true);
    Get.lazyPut(() => ZoneController(), fenix: true);
    Get.lazyPut(() => InnerProductController(), fenix: true);
    Get.lazyPut(() => DeliveryController(), fenix: true);
    Get.lazyPut(() => CreditCardController(), fenix: true);
    Get.lazyPut(() => CustomerLocationController(), fenix: true);
    Get.lazyPut(() => CustomerSummaryController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => ShippingInformationController(), fenix: true);
    Get.lazyPut(() => AddressDetailsController(), fenix: true);
    Get.lazyPut(() => MapController(), fenix: true);
    Get.lazyPut(() => SelectLocationFromMapController(), fenix: true);
    Get.lazyPut(() => AddReviewController(), fenix: true);
    Get.lazyPut(() => SubscribeController(), fenix: true);
    Get.lazyPut(() => ContactUsController(), fenix: true);
    Get.lazyPut(() => VerifyOtpForgetPasswordController(), fenix: true);
    Get.lazyPut(() => NewPasswordController(), fenix: true);
    Get.lazyPut(() => StoresController(), fenix: true);
    Get.lazyPut(() => TermsOfServiceController(), fenix: true);
    Get.lazyPut(() => LanguageController(), fenix: true);
    Get.lazyPut(() => AllReviewsController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => SearchController(), fenix: true);
    Get.lazyPut(() => PreBookingPolicyController(), fenix: true);
  }
}
