import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/components/custom_bottom_navigation_bar.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/no_internet_widget.dart';
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
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var body = Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: CustomConnectivityAlertWidget(
        onlineWidget: PageView(
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
    );
    return pageIndex == 2
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            bottomNavigationBar: CustomBottomNavigationBar(
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
            body: body,
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar:
                CustomAppBar(title: BottomAppBarItemsData.labelList[pageIndex]),
            bottomNavigationBar: CustomBottomNavigationBar(
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
            body: body,
          );
  }
}
