import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/core/utils/theme.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/payment_controller.dart';
import 'checkout_title_divider_widget.dart';

class ChoicePaymentMethodWidget extends StatefulWidget {
  const ChoicePaymentMethodWidget(
      {Key? key, this.groupValue, required this.payments})
      : super(key: key);
  final int? groupValue;
  final List<PaymentOptionsModel> payments;

  @override
  State<ChoicePaymentMethodWidget> createState() =>
      _ChoicePaymentMethodWidgetState();
}

class _ChoicePaymentMethodWidgetState extends State<ChoicePaymentMethodWidget> {
  late int? groupValue;
  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  void initState() {
    super.initState();
    groupValue = widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = CustomThemes.appTheme.primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckOutTitleDividerWidget(title: Translate.paymentsMethod.tr),
        Theme(
          data: ThemeData.light().copyWith(unselectedWidgetColor: primaryColor),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.payments.length,
            itemBuilder: (BuildContext context, int index) {
              final payment = widget.payments.elementAt(index);
              return Column(
                children: [
                  RadioListTile<int>(
                    controlAffinity: ListTileControlAffinity.trailing,
                    value: index,
                    contentPadding: const EdgeInsets.all(0),
                    groupValue: groupValue,
                    activeColor: primaryColor,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                payment.title ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                              Offstage(
                                offstage: payment.additionalFees == null,
                                child: CustomText(
                                  '${Translate.additionalFees.tr}: ${payment.additionalFees?.toStringAsFixed(payment.additionalFees!.truncateToDouble() == payment.additionalFees ? 0 : 1) ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 8, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CachedNetworkImage(
                            width: 40,
                            height: 20,
                            imageUrl: payment.image ?? '',
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error_outline),
                            ),
                            progressIndicatorBuilder: (_, __, ___) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryColor),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    onChanged: (int? value) {
                      setState(() {
                        groupValue = value;
                        paymentController.paymentOptionId =
                            widget.payments.elementAt(index).id;
                      });
                    },
                  ),
                  index != widget.payments.length - 1
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: DottedLine(dashColor: AppColors.redColor),
                        )
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
