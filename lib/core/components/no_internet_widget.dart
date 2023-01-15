import 'package:connectivity_alert_widget/connectivity_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../localization/translate.dart';
import '../utils/theme.dart';
import 'custom_button.dart';

class NoInternetWidget extends StatelessWidget {
  final Function()? onReload;
  const NoInternetWidget({Key? key, this.onReload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/network_icon.png",
              width: .3.sw,
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: Translate.noInternetConnection.tr,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0)),
                  TextSpan(
                    text: '\n\n ${Translate.checkYourInternetConnection.tr}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff404041),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Offstage(
              offstage: (onReload == null),
              child: SizedBox(
                width: 100,
                child: CustomButton(
                  enabled: true,
                  color: CustomThemes.lightThemeData.primaryColor,
                  onTap: onReload ?? () {},
                  textColor: Colors.white,
                  title: 'Reload',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomConnectivityAlertWidget extends StatelessWidget {
  final Widget onlineWidget;
  final Function()? onOnlineCallBack;
  final Function()? onReload;
  const CustomConnectivityAlertWidget(
      {Key? key,
      required this.onlineWidget,
      this.onOnlineCallBack,
      this.onReload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConnectivityAlertWidget(
        offlineWidget: Center(
            child: NoInternetWidget(
          onReload: onReload,
        )),
        onlineWidget: onlineWidget,
        onConnectivityResult: onOnlineCallBack == null
            ? (connectivity) {}
            : (connectivity) {
                // if (connectivity == ConnectivityResult.wifi ||
                //     connectivity == ConnectivityResult.mobile) {
                //   onOnlineCallBack!();
                // }
              });
  }
}
