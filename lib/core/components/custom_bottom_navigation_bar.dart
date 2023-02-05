import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:imtnan/core/localization/translate.dart';
import 'package:imtnan/core/utils/theme.dart';
import 'custom_text.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int pageIndex;
  final Function(int) onChanged;
  final void Function()? onItemTapped;
  final void Function()? onImageTapped;

  const CustomBottomNavigationBar(
      {Key? key,
      required this.pageIndex,
      required this.onChanged,
      this.onItemTapped,
      this.onImageTapped})
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Color bottomColor = CustomThemes.appTheme.disabledColor;
    AnimationController? hideAnimationController;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SvgPicture.asset(
          'assets/images/menu_bg.svg',
          width: MediaQuery.of(context).size.width,
          height: 60,
          fit: BoxFit.fitHeight,
        ),
        AnimatedBottomNavigationBar.builder(
          backgroundColor: Colors.transparent,
          itemCount: 5,
          activeIndex: widget.pageIndex,
          splashRadius: 0,
          elevation: 0,
          hideAnimationCurve: Curves.easeInBack,
          hideAnimationController: hideAnimationController,
          splashSpeedInMilliseconds: 0,
          gapWidth: 0,
          height: 60.0,
          tabBuilder: (int index, bool isActive) {
            bottomColor =
                isActive ? CustomThemes.appTheme.primaryColor : Colors.white;
            return InkWell(
              onTap: widget.onItemTapped,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isActive
                      ? BottomAppBarItemsData.activeIconsList[index]
                      : BottomAppBarItemsData.iconsList[index],
                  CustomText(
                    BottomAppBarItemsData.labelList[index],
                    style: TextStyle(
                      color: bottomColor,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          },
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: widget.onChanged,
        ),
        GestureDetector(
          onTap: widget.onImageTapped,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Image.asset("assets/images/logo_white.png",
                width: 100, height: 80),
          ),
        ),
      ],
    );
  }
}

class BottomAppBarItemsData {
  static const iconsList = <Widget>[
    Icon(Icons.restaurant_menu, size: 22, color: Colors.white),
    Icon(Icons.favorite, size: 22, color: Colors.white),
    Icon(Icons.home, size: 22, color: Colors.white),
    Icon(Icons.shopping_cart, size: 22, color: Colors.white),
    Icon(Icons.people_rounded, size: 22, color: Colors.white)
  ];
  static const activeIconsList = <Widget>[
    Icon(Icons.restaurant_menu, color: Color(0xff00754D), size: 22),
    Icon(Icons.favorite, color: Color(0xff00754D), size: 22),
    Icon(Icons.home, color: Color(0xff00754D), size: 22),
    Icon(Icons.shopping_cart, color: Color(0xff00754D), size: 22),
    Icon(Icons.people_rounded, color: Color(0xff00754D), size: 22)
  ];

  static final labelList = <String>[
    Translate.menu.tr,
    Translate.wishlist.tr,
    Translate.home.tr,
    Translate.myCart.tr,
    Translate.account.tr,
  ];
}
