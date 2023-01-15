import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/core/models/address_model.dart';

import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';

class AddressBookItemWidget extends StatelessWidget {
  final AddressModel? address;
  final VoidCallback? editAddressAction;
  final VoidCallback? deleteAddressAction;
  const AddressBookItemWidget({
    this.address,
    Key? key,
    this.editAddressAction,
    this.deleteAddressAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: CustomThemes.appTheme.primaryColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: const EdgeInsets.only(top: 3),
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                    color: CustomThemes.appTheme.primaryColor, width: 1.5),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: address?.isDefault ?? false
                      ? CustomThemes.appTheme.primaryColor
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    address?.address ?? '',
                    style: TextStyle(
                      color: CustomThemes.appTheme.colorScheme.secondary,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomText(
                    "${address?.firstName} ${address?.lastName}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomText(
                    address?.city?.name ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  CustomText(
                    address?.mobile ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Visibility(
                    visible: address?.isDefault ?? false,
                    child: CustomText(
                      Translate.defaultAddress.name.tr,
                      style: TextStyle(
                          color: CustomThemes.appTheme.primaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            ButtonsRowWidget(
              orderCount: address?.orderCount ?? 0,
              deleteAddressAction: deleteAddressAction,
              editAddressAction: editAddressAction,
              isDefaultAddress: address?.isDefault,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonsRowWidget extends StatelessWidget {
  final bool? isDefaultAddress;
  final VoidCallback? editAddressAction;
  final VoidCallback? deleteAddressAction;
  final int orderCount;

  const ButtonsRowWidget({
    Key? key,
    this.isDefaultAddress,
    this.editAddressAction,
    this.deleteAddressAction,
    required this.orderCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: editAddressAction,
            child: FaIcon(
              FontAwesomeIcons.penToSquare,
              size: 18,
              color: CustomThemes.appTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: isDefaultAddress == true || orderCount > 0
                ? () {}
                : () {
                    Get.defaultDialog(
                      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      titlePadding: const EdgeInsets.only(top: 20),
                      title: Translate.delete.name.tr,
                      titleStyle: TextStyle(
                          color: CustomThemes.appTheme.colorScheme.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0),
                      middleText: Translate.deleteAddressConfirm.name.tr,
                      middleTextStyle: TextStyle(
                          color: CustomThemes.appTheme.colorScheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0),
                      actions: [
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            side: BorderSide(
                                color: CustomThemes.appTheme.primaryColor,
                                width: 1.5),
                            elevation: 1,
                          ),
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                          child: CustomText(
                            Translate.no.name.tr,
                            style: TextStyle(
                              color: CustomThemes.appTheme.primaryColor,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CustomThemes.appTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 1,
                          ),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            deleteAddressAction!();
                          },
                          child: CustomText(
                            Translate.yes.name.tr,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      barrierDismissible: true,
                    );
                  },
            child: FaIcon(
              FontAwesomeIcons.trash,
              size: 18,
              color: isDefaultAddress == true || orderCount > 0
                  ? Colors.grey
                  : CustomThemes.appTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
