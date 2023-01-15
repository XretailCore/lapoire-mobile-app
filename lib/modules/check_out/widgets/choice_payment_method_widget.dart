import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../controllers/payment_controller.dart';

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
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            '${Translate.chooseOneOfThesePaymentMethods.tr} :',
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(108, 108, 108, 1),
            ),
          ),
          Theme(
            data: ThemeData.light().copyWith(
              unselectedWidgetColor: Colors.black,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.payments.length,
              itemBuilder: (BuildContext context, int index) {
                final payment = widget.payments.elementAt(index);
                return Container(
                  // height: 45,
                  margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: index == widget.payments.length - 1
                            ? Colors.transparent
                            : const Color.fromRGBO(134, 134, 134, .3),
                      ),
                    ),
                  ),
                  child: RadioListTile<int>(
                    value: index,
                    contentPadding: const EdgeInsets.all(0),
                    groupValue: groupValue,
                    activeColor: primaryColor,
                    title: Row(
                      children: [
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
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(primaryColor),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(payment.title ?? ''),
                            Offstage(
                              offstage: payment.additionalFees == null,
                              child: CustomText(
                                '${Translate.additionalFees.tr}: ${payment.additionalFees?.toString() ?? ''}',
                                style: const TextStyle(fontSize: 8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onChanged: (int? value) {
                      setState(() {
                        groupValue = value;
                        paymentController.paymentOptionId =
                            widget.payments.elementAt(index).id;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
