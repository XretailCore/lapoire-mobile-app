import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/cart/controllers/cart_controller.dart';
import '../../modules/home/widgets/home_search_widget.dart';
import '../../modules/order_details/controllers/order_details_controller.dart';
import '../../modules/search/controller/search_controller.dart';
import '../localization/translate.dart';
import '../utils/app_colors.dart';
import '../utils/routes.dart';
import '../utils/theme.dart';
import 'custom_back_button.dart';
import 'custom_text.dart';
import 'custom_text_field.dart';

class CustomTitledAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool showCart;
  final Function()? onCartTap;
  final List<Widget> actionsWidget;

  const CustomTitledAppBar({
    Key? key,
    this.title = "",
    this.showCart = false,
    this.onCartTap,
    this.actionsWidget = const [],
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: CustomThemes.appTheme.primaryColor),
      backgroundColor: Colors.white,
      elevation: 1,
      title: CustomText(
        title,
        style: TextStyle(
          color: CustomThemes.appTheme.primaryColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      centerTitle: true,
      actions: actionsWidget.isNotEmpty
          ? actionsWidget
          : [
              Offstage(
                offstage: !showCart,
                child: InkWell(
                  onTap: onCartTap ?? () {},
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: CartIconWithCounterWidget(),
                  ),
                ),
              ),
            ],
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCart;
  final Function()? onCartTap;

  const HomeAppBar({
    Key? key,
    this.title = "",
    this.showCart = false,
    this.onCartTap,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme:
          IconThemeData(color: CustomThemes.appTheme.colorScheme.secondary),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: CustomText(
        title,
        style: TextStyle(
          color: CustomThemes.appTheme.colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Image.asset('assets/images/main_logo.png'),
      actions: [
        Offstage(
          offstage: !showCart,
          child: InkWell(
            onTap: onCartTap ?? () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.shopping_cart,
                color: CustomThemes.appTheme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderDetailsAppBar extends GetView<OrderDetailsController>
    implements PreferredSizeWidget {
  final String title;
  final Widget? bottom;
  const OrderDetailsAppBar({
    Key? key,
    this.title = "",
    this.bottom,
  }) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(70);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: bottom ?? const SizedBox(),
          )),
      backgroundColor: AppColors.highlighter,
      iconTheme: IconThemeData(color: CustomThemes.appTheme.primaryColor),
      elevation: 1,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: CustomText(
          title,
          style: TextStyle(color: CustomThemes.appTheme.primaryColor),
        ),
      ),
      leading: Visibility(
        visible: Navigator.of(context).canPop(),
        replacement: IconButton(
          onPressed: () => controller.goToHomeAction(),
          icon: const Icon(Icons.home, color: AppColors.primaryColor),
        ),
        child: const CustomBackButton(),
      ),
    );
  }
}

class CustomAppBar extends GetView<CartController>
    implements PreferredSizeWidget {
  final String title;
  final bool showCart;
  final bool showSearch;
  final bool showBackButton;
  final bool showAction;
  final bool showBottom;
  final Widget? bottom;

  const CustomAppBar({
    Key? key,
    this.title = "",
    this.bottom,
    this.showBackButton = false,
    this.showAction = true,
    this.showCart = true,
    this.showBottom = false,
    this.showSearch = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: bottom ?? const SizedBox(),
          )),
      iconTheme: IconThemeData(color: CustomThemes.appTheme.primaryColor),
      backgroundColor: AppColors.highlighter,
      elevation: 1,
      title: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: CustomText(
          title,
          style: TextStyle(
              color: CustomThemes.appTheme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      centerTitle: true,
      leading: showBackButton ? const CustomBackButton() : const SizedBox(),
      actions: showAction
          ? [
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.search);
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 15.0, right: 12.0, left: 12),
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
            ]
          : [],
    );
  }
}

class SearchAppBar extends GetView<SearchController>
    implements PreferredSizeWidget {
  final Function()? onSearchTap;

  const SearchAppBar({Key? key, this.onSearchTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      backgroundColor: CustomThemes.appTheme.primaryColor,
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.only(top: 5.0, end: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: CustomSearchTextField(
              controller: controller.searchController,
              labelText: Translate.searchHere.tr,
              validator: (val) {
                return null;
              },
              onSave: (searchText) => controller.onRefresh(showLoader: true),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DashboardCustomAppBar extends GetView<CartController>
    implements PreferredSizeWidget {
  const DashboardCustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme:
          IconThemeData(color: CustomThemes.appTheme.colorScheme.secondary),
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/images/main_logo.png',
            width: 120,
            height: 45,
          ),
          const Spacer(),
          InkWell(
              onTap: () {
                Get.toNamed(Routes.search);
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 0, 15),
                child: Icon(
                  Icons.search,
                  color: CustomThemes.appTheme.primaryColor,
                ),
              )),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.cart);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 0, 15),
              child: badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.white,
                  padding:
                      EdgeInsets.all(controller.cartCounter.value < 9 ? 4 : 3),
                ),
                position: badges.BadgePosition.topEnd(),
                badgeContent: Obx(
                  () => CustomText(
                    controller.cartCounter.value.toString(),
                    style: TextStyle(
                      color: CustomThemes.appTheme.primaryColor,
                      fontSize: 11,
                    ),
                  ),
                ),
                badgeAnimation: const badges.BadgeAnimation.scale(
                    toAnimate: true, animationDuration: Duration(seconds: 1)),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomThemes.appTheme.primaryColor,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      leading: null,
    );
  }
}
