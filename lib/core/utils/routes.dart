import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/address_details/view/address_details_screen.dart';
import '../../modules/auth/screens/change_password_screen.dart';
import '../../modules/auth/screens/forget_password_screen.dart';
import '../../modules/auth/screens/new_password_screen.dart';
import '../../modules/auth/screens/profile_screen.dart';
import '../../modules/auth/screens/sign_widget.dart';
import '../../modules/auth/screens/terms_of_service_screen.dart';
import '../../modules/auth/screens/verify_otp_forget_password_screen.dart';
import '../../modules/auth/screens/verify_otp_screen.dart';
import '../../modules/cart/view/cart_screen.dart';
import '../../modules/categories/view/categories_screen.dart';
import '../../modules/check_out/views/checkout_confirmation_screen.dart';
import '../../modules/check_out/views/credit_card_screen.dart';
import '../../modules/check_out/views/customer_locations_screen.dart';
import '../../modules/check_out/views/payment_screen.dart';
import '../../modules/check_out/views/shipping_information_screen.dart';
import '../../modules/choose_zone/view/choose_zone_screen.dart';
import '../../modules/contact_us/views/contact_us_screens.dart';
import '../../modules/content/view/content_screen.dart';
import '../../modules/dashboard/view/dashboard_screen.dart';
import '../../modules/home/view/home_screen.dart';
import '../../modules/inner/views/inner_product_screen.dart';
import '../../modules/intro/views/intro_screen.dart';
import '../../modules/listing_items/view/listing_screen.dart';
import '../../modules/map/views/map_screen.dart';
import '../../modules/my_account/views/my_account_screen.dart';
import '../../modules/my_addresses/view/my_addresses_screen.dart';
import '../../modules/my_orders/view/my_order_screen.dart';
import '../../modules/order_details/view/order_details_screen.dart';
import '../../modules/order_track/view/track_order_screen.dart';
import '../../modules/review/screens/all_reviews_screen.dart';
import '../../modules/search/view/search_screen.dart';
import '../../modules/select_location_from_map/screens/select_location_from_map_screen.dart';
import '../../modules/settings/view/language_screen.dart';
import '../../modules/settings/view/settings_screen.dart';
import '../../modules/settings/view/subscribe_screen.dart';
import '../../modules/splash/views/splash_screen.dart';
import '../../modules/stores/views/stores_screen.dart';
import '../../modules/wishlist/views/wishlist_screen.dart';

class Routes {
  const Routes();
  static const splashscreen = '/',
      intro = '/intro',
      home = '/home',
      categories = "/categories",
      cart = "/mybasket",
      sign = '/sign',
      verifyOtpScreen = '/verifyOtpScreen',
      verifyOtpForgetPasswordScreen = '/verifyOtpForgetPasswordScreen',
      changePasswordScreen = '/changePasswordScreen',
      listingItems = '/listingItems',
      content = '/contentScreen',
      forgetPasswordScreen = '/forgetPasswordScreen',
      profile = '/profile',
      addresses = '/myaddresses',
      settings = '/settings',
      orderDetails = '/orderDetails',
      trackOrder = '/trackOrder',
      chooseZoneScreen = '/zoneScreen',
      myorders = '/myorders',
      addressDetails = '/addressDetailsScreen',
      map = '/mapScreen',
      selectLocationFromMapScreen = '/selectLocationFromMapScreen',
      innerScreen = '/innerScreen',
      storesLocationScreen = '/storesLocationScreen',
      customerLocationsScreen = '/customerLocationsScreen',
      paymentScreen = '/paymentScreen',
      creditCardScreen = '/creditCardScreen',
      summaryScreen = '/summaryScreen',
      checkoutConfirmationScreen = '/checkoutConfirmationScreen',
      deliveryScreen = '/deliveryScreen',
      subscribeScreen = '/subscribeScreen',
      contactUsScreen = '/contactus',
      newPasswordScreen = '/newPasswordScreen',
      branchs = '/branches',
      termsOfServiceScreen = '/termsOfServiceScreen',
      languageScreen = '/language',
      dashboard = '/dashboard',
      wishlist = '/wishlist',
      myAccount = '/myAccount',
      search = '/search',
      allReviewsScreen = '/allReviewsScreen';
  static const instance = Routes();

  List<GetPage<Widget>> getScreens() {
    return <GetPage<Widget>>[
      GetPage(
          name: changePasswordScreen, page: () => const ChangePasswordScreen()),
      GetPage(
          name: forgetPasswordScreen, page: () => const ForgetPasswordScreen()),
      GetPage(name: splashscreen, page: () => const SplashScreen()),
      GetPage(name: intro, page: () => const IntroScreen()),
      GetPage(name: home, page: () => const HomeScreen()),
      GetPage(name: sign, page: () => const SignWidget()),
      GetPage(name: categories, page: () => const CategoriesScreen()),
      GetPage(name: cart, page: () => const CartScreen()),
      GetPage(name: verifyOtpScreen, page: () => const VerifyOtpScreen()),
      GetPage(name: listingItems, page: () => ListItemsScreen()),
      GetPage(name: content, page: () => const ContentScreen()),
      GetPage(name: myorders, page: () => const MyOrdersScreen()),
      GetPage(name: profile, page: () => const ProfileScreen()),
      GetPage(name: settings, page: () => const SettingsScreen()),
      GetPage(name: addresses, page: () => const MyAddressesScreen()),
      GetPage(name: orderDetails, page: () => const OrderDetailsScreen()),
      GetPage(name: trackOrder, page: () => const TrackOrderScreen()),
      GetPage(name: chooseZoneScreen, page: () => const ChooseZoneScreen()),
      GetPage(name: innerScreen, page: () => const InnerProductScreen()),
      GetPage(name: addressDetails, page: () => const AddressDetailsScreen()),
      GetPage(
          name: customerLocationsScreen, page: () => CustomerLocationsScreen()),
      GetPage(name: paymentScreen, page: () => PaymentScreen()),
      GetPage(name: creditCardScreen, page: () => const CreditCardScreen()),
      GetPage(
          name: summaryScreen, page: () => const ShoppingInformationScreen()),
      GetPage(
          name: checkoutConfirmationScreen,
          page: () => const CheckoutConfirmationScreen()),
      GetPage(name: map, page: () => const MapScreen()),
      GetPage(
          name: selectLocationFromMapScreen,
          page: () => const SelectLocationFromMapScreen()),
      GetPage(name: subscribeScreen, page: () => const SubscribeScreen()),
      GetPage(name: contactUsScreen, page: () => const ContactUsScreen()),
      GetPage(
          name: verifyOtpForgetPasswordScreen,
          page: () => const VerifyOtpForgetPasswordScreen()),
      GetPage(name: newPasswordScreen, page: () => const NewPasswordScreen()),
      GetPage(name: branchs, page: () => const StoresScreen()),
      GetPage(
          name: termsOfServiceScreen, page: () => const TermsOfSerivceScreen()),
      GetPage(name: languageScreen, page: () => const LanguageScreen()),
      GetPage(name: allReviewsScreen, page: () => const AllReviwesScreen()),
      GetPage(name: wishlist, page: () => const WishlistScreen()),
      GetPage(name: dashboard, page: () => DashboardScreen()),
      GetPage(name: myAccount, page: () => const MyAccountScreen()),
      GetPage(name: search, page: () => const SearchScreen()),
    ];
  }
}
