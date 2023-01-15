import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../my_account/controllers/my_account_controller.dart';
import '../../../core/localization/translate.dart';

import '../../../core/components/card_account_summary_widget.dart';

class AccountSummaryWidget extends GetView<MyAccountController> {
  const AccountSummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (customerSummary) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            if (customerSummary?.loyaltyPointsEnabled ?? false)
              Expanded(
                child: CardAccountSummaryWidget(
                  countLabel: (customerSummary?.loyaltyPoints ?? 0).toString(),
                  title: Translate.loyaltyPoints.tr,
                ),
              ),
            SizedBox(
                width:
                    (customerSummary?.loyaltyPointsEnabled ?? false) ? 8 : 0),
            Expanded(
              child: CardAccountSummaryWidget(
                countLabel: (customerSummary?.wishListCount ?? 0).toString(),
                title: Translate.wishlist.tr,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CardAccountSummaryWidget(
                countLabel: (customerSummary?.ordersThisMonth ?? 0).toString(),
                title: Translate.ordersThisMonth.tr,
              ),
            ),
          ],
        ),
      ),
      onLoading: const CircularProgressIndicator(
        color: Colors.white,
      ),
      onError: (e) => CustomErrorWidget(
        errorText: e,
        onReload: controller.getCustomerSummary,
      ),
    );
  }
}
