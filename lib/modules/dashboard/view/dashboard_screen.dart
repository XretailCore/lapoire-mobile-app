import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_bottom_navigation_bar.dart';
import 'package:imtnan/core/components/custom_text.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/no_internet_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../cart/view/cart_screen.dart';
import '../../categories/view/categories_screen.dart';
import '../../home/view/home_screen.dart';
import '../../my_account/views/my_account_screen.dart';
import '../../wishlist/views/wishlist_screen.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  final CartController cartController = Get.find<CartController>();
  final UserSharedPrefrenceController userSharedPrefrenceController =
      Get.find<UserSharedPrefrenceController>();
  int pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    var body = CustomConnectivityAlertWidget(
      onlineWidget: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: PageView(
              controller: dashboardController.navigationBarController,
              allowImplicitScrolling: false,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  pageIndex = index;
                  dashboardController.navigationBarController.jumpToPage(index);
                });
              },
              children: const [
                CategoriesScreen(),
                WishlistScreen(),
                HomeScreen(),
                CartScreen(),
                MyAccountScreen(),
              ],
            ),
          ),
          CustomBottomNavigationBar(
            onImageTapped: () {
              pageIndex = 2;
              dashboardController.navigationBarController.jumpToPage(2);
            },
            pageIndex: pageIndex,
            onChanged: (index) => setState(
              () {
                pageIndex = index;
                dashboardController.navigationBarController.jumpToPage(index);
              },
            ),
          ),
        ],
      ),
    );
    return pageIndex == 2
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: body,
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar: CustomAppBar(
              bottom: pageIndex == 4
                  ? CustomText(
                      userSharedPrefrenceController.getUserEmail,
                      style: const TextStyle(
                        color: AppColors.redColor,
                      ),
                    )
                  : const SizedBox(),
              title: pageIndex == 4
                  ? "${Translate.hello.tr} ${userSharedPrefrenceController.getUserFirstName}"
                  : BottomAppBarItemsData.labelList[pageIndex],
              showAction: pageIndex == 4 ? false : true,
            ),
            body: body,
          );
  }
}
