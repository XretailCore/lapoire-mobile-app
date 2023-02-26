import 'package:flutter/material.dart';
import 'package:imtnan/core/components/custom_button.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';
import '../../../core/localization/translate.dart';

class DetailsBuyNowWidget extends StatelessWidget {
  const DetailsBuyNowWidget({
    Key? key,
    required this.details,
    required this.onTap,
  }) : super(key: key);

  final OneClickOrderDetailsModel? details;

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Material(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.highlighter,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.rich(TextSpan(
                      text: Translate.cashOnDeliveryFees.tr,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '  ${details?.codFees!.toStringAsFixed(details?.codFees!.truncateToDouble() == details?.codFees ? 0 : 1)}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        ),
                        TextSpan(
                          text: '  ${Translate.egp.tr}',
                          style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        ),
                      ])),
                  const SizedBox(height: 8),
                  Text.rich(TextSpan(
                      text: Translate.shipmentfees.tr,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '  ${details?.shipmentFees!.toStringAsFixed(details?.shipmentFees!.truncateToDouble() == details?.shipmentFees ? 0 : 1)}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        ),
                        TextSpan(
                          text: '  ${Translate.egp.tr}',
                          style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        ),
                      ])),
                  const SizedBox(height: 8),
                  Text.rich(TextSpan(
                      text: Translate.address.tr,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '  ${details?.address}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        )
                      ])),
                  const SizedBox(height: 8),
                  Text.rich(TextSpan(
                      text: Translate.buyNowTotal.tr,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '  ${details?.total!.toStringAsFixed(details?.total!.truncateToDouble() == details?.total ? 0 : 1)}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        ),
                        TextSpan(
                          text: '  ${Translate.egp.tr}',
                          style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal,color: AppColors.primaryColor,),
                        ),
                      ])),
                  const SizedBox(height: 20),
                  Center(
                      child: SizedBox(
                          width: 200,
                          child: CustomBorderButton(
                            radius: 30.0,
                              color: AppColors.redColor,
                              onTap: onTap, title: Translate.confirm.tr))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
