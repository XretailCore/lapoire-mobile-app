import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../localization/translate.dart';
import '../utils/theme.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function()? onReload;
  final String? errorText;
  const CustomErrorWidget({Key? key, this.onReload, this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/error_icon.png",
              width: .2.sw,
              color: CustomThemes.appTheme.primaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    Translate.errorOccurred.tr,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Offstage(
              offstage: (onReload == null),
              child: SizedBox(
                width: 150,
                child: CustomButton(
                  enabled: true,
                  color: CustomThemes.appTheme.primaryColor,
                  onTap: onReload ?? () {},
                  textColor: Colors.white,
                  title: Translate.reload.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
