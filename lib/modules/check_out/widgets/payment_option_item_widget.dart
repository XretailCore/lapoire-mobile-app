import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/theme.dart';
import '../controllers/payment_controller.dart';

class PaymentOptionItemWidget extends StatefulWidget {
  const PaymentOptionItemWidget(
      {Key? key, required this.payments})
      : super(key: key);
  final List<PaymentOptionsModel> payments;

  @override
  State<PaymentOptionItemWidget> createState() => _PaymentOptionItemWidgetState();
}

class _PaymentOptionItemWidgetState extends State<PaymentOptionItemWidget> {
  final PaymentController paymentController = Get.find<PaymentController>();
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (controller) {
      return Scrollbar(
        child: ListView.separated(
          itemCount: widget.payments.length,
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemBuilder: (_, index) {
            final payment = widget.payments.elementAt(index);
            return Column(
              children: [
                PaymentOptionWidget(
                  payment: payment,
                  isSelected: selectedIndex == payment.id!-1,
                  showRadioButton: true,
                  onTap: () {
                    setState(() {
                      selectedIndex=index;
                      paymentController.paymentOptionId =
                          widget.payments.elementAt(index).id;
                    });
                    //controller.onSelectAddress(context, payment);
                  },
                ),
                index != widget.payments.length - 1
                    ? const DottedLine(dashColor: AppColors.redColor)
                    : const SizedBox(),
              ],
            );
          },
        ),
      );
    });
  }
}

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({
    Key? key,
    required this.payment,
    this.isSelected = false,
    required this.onTap,
    this.checked = false,
    this.showRadioButton = false,
  }) : super(key: key);
  final PaymentOptionsModel payment;
  final bool isSelected;
  final VoidCallback onTap;
  final bool checked;
  final bool showRadioButton;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                trailing: CachedNetworkImage(
                  width: 40,
                  height: 20,
                  imageUrl: payment.image ?? '',
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error_outline),
                  ),
                  progressIndicatorBuilder: (_, __, ___) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                      ),
                    );
                  },
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      payment.title ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Offstage(
                      offstage: payment.additionalFees == null,
                      child: CustomText(
                        '${Translate.additionalFees.tr}: ${payment.additionalFees?.toString() ?? ''}',
                        style: const TextStyle(
                            fontSize: 8, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: const EdgeInsets.only(top: 3),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected
                    ? CustomThemes.appTheme.primaryColor
                    : Colors.white,
                border: Border.all(
                    color: CustomThemes.appTheme.primaryColor, width: 1.5),
                shape: BoxShape.circle,
              ),
              child: const FaIcon(FontAwesomeIcons.check,
                  color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
// Row(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//
//     const SizedBox(width: 8),
//     Expanded(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           CustomText(
//             payment.title,
//             style: TextStyle(
//               color: CustomThemes.appTheme.primaryColor,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 3),
//           CustomText(
//             payment.code,
//             style: TextStyle(
//               color: CustomThemes.appTheme.primaryColor,
//               fontWeight: FontWeight.w400,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 3),
//           CustomText(
//             payment.id.toString(),
//             style: TextStyle(
//               color: CustomThemes.appTheme.primaryColor,
//               fontWeight: FontWeight.w400,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           const SizedBox(height: 3),
//           CustomText(
//             payment.id.toString(),
//             style: TextStyle(
//               color: CustomThemes.appTheme.primaryColor,
//               fontWeight: FontWeight.w400,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(height: payment.id.toString() == "" ? 0 : 3),
//           Offstage(
//             offstage: (payment.id.toString() == ""),
//             child: CustomText(
//               payment.id.toString(),
//               style: TextStyle(
//                 color: CustomThemes.appTheme.primaryColor,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
