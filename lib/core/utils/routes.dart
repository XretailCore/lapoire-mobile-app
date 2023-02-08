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
import '../../modules/check_out/views/checkout_options_screen.dart';
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
      checkOutOptionsScreen = '/checkOutOptionsScreen',
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
          name: changePasswordScreen,
          page: () => const ChangePasswordScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: forgetPasswordScreen,
          page: () => const ForgetPasswordScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(name: splashscreen, page: () => const SplashScreen()),
      GetPage(name: intro, page: () => const IntroScreen()),
      GetPage(
        name: home,
        page: () => const HomeScreen(),
      ),
      GetPage(
          name: sign,
          page: () => const SignWidget(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(name: categories, page: () => const CategoriesScreen()),
      GetPage(name: cart, page: () => const CartScreen()),
      GetPage(name: checkOutOptionsScreen, page: () =>  CheckoutOptionsScreen()),
      GetPage(
          name: verifyOtpScreen,
          page: () => const VerifyOtpScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: listingItems,
          page: () => ListItemsScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: content,
          page: () => const ContentScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: myorders,
          page: () => const MyOrdersScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: profile,
          page: () => const ProfileScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: settings,
          page: () => const SettingsScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: addresses,
          page: () => const MyAddressesScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: orderDetails,
          page: () => const OrderDetailsScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: trackOrder,
          page: () => const TrackOrderScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: chooseZoneScreen,
          page: () => const ChooseZoneScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: innerScreen,
          page: () => const InnerProductScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: addressDetails,
          page: () => const AddressDetailsScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: customerLocationsScreen,
          page: () => CustomerLocationsScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: paymentScreen,
          page: () => PaymentScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: creditCardScreen,
          page: () => const CreditCardScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: summaryScreen,
          page: () => const ShoppingInformationScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: checkoutConfirmationScreen,
          page: () => const CheckoutConfirmationScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: map,
          page: () => const MapScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: selectLocationFromMapScreen,
          page: () => const SelectLocationFromMapScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: subscribeScreen,
          page: () => const SubscribeScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: contactUsScreen,
          page: () => const ContactUsScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: verifyOtpForgetPasswordScreen,
          page: () => const VerifyOtpForgetPasswordScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: newPasswordScreen,
          page: () => const NewPasswordScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: branchs,
          page: () => const StoresScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: termsOfServiceScreen,
          page: () => const TermsOfSerivceScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: languageScreen,
          page: () => const LanguageScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(
          name: allReviewsScreen,
          page: () => const AllReviwesScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transition: Transition.cupertino),
      GetPage(name: wishlist, page: () => const WishlistScreen()),
      GetPage(
          name: dashboard,
          page: () => DashboardScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transition: Transition.cupertino),
      GetPage(name: myAccount, page: () => const MyAccountScreen()),
      GetPage(name: search, page: () => const SearchScreen()),
    ];
  }
}
