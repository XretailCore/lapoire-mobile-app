import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../../../core/utils/validator.dart';
import '../controllers/address_details_controller.dart';
import 'card_entry_widget.dart';
import 'district_widget.dart';
import 'is_default_switch_widget.dart';
import 'zone_widget.dart';

class AddressDetailsForm extends GetView<AddressDetailsController> {
  const AddressDetailsForm({Key? key, required this.zones}) : super(key: key);
  final List<CityModel> zones;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CardEntryWidget(
                    placeHolderLabel: '${Translate.firstName.tr} *',
                    textEditingController: controller.firstNameTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CardEntryWidget(
                    placeHolderLabel: '${Translate.lastName.tr} *',
                    textEditingController: controller.lastNameTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CardEntryWidget(
              placeHolderLabel: '${Translate.addressName.tr} *',
              textEditingController: controller.addressNameTEC,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            CardEntryWidget(
              placeHolderLabel: '${Translate.streetName.tr} *',
              textEditingController: controller.streetNameTEC,
              textInputType: TextInputType.name,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            CardEntryWidget(
              placeHolderLabel: '${Translate.buildingNumber.tr} *',
              textEditingController: controller.buildingNumberTEC,
              textInputType: TextInputType.name,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            CardEntryWidget(
              placeHolderLabel: '${Translate.floorNumber.tr} *',
              textEditingController: controller.floorNumberTEC,
              textInputType: TextInputType.name,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            CardEntryWidget(
              placeHolderLabel: '${Translate.apartmentNumber.tr} *',
              textEditingController: controller.apartmentNumberTEC,
              textInputType: TextInputType.name,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            ZoneWidget(
              cities: zones,
            ),
            const SizedBox(height: 10),
            const DistrictWidget(),
            const SizedBox(height: 10),
            CardEntryWidget(
              placeHolderLabel: '${Translate.mobileNumber.tr} *',
              textEditingController: controller.mobileTEC,
              textInputType: TextInputType.phone,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            const IsDefaultSwitchWidget(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
              child: CustomButton(
                color: CustomThemes.appTheme.primaryColor,
                onTap: () => controller.saveAddress(context: context),
                textColor: Colors.white,
                title: Translate.save.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
