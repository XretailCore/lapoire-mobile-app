import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/text_form_field_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/validator.dart';
import '../controllers/address_details_controller.dart';
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
                  child: TextFormFieldWidget(
                    hint: '${Translate.firstName.tr} *',
                    textEditingController: controller.firstNameTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.lastName.tr} *',
                    textEditingController: controller.lastNameTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hint: '${Translate.addressName.tr} *',
              textEditingController: controller.addressNameTEC,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hint: '${Translate.streetName.tr} *',
              textEditingController: controller.streetNameTEC,
              textInputType: TextInputType.name,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.buildingNumber.tr} *',
                    textEditingController: controller.buildingNumberTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.floorNumber.tr} *',
                    textEditingController: controller.floorNumberTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.apartmentNumber.tr} *',
                    textEditingController: controller.apartmentNumberTEC,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ZoneWidget(
              cities: zones,
            ),
            const SizedBox(height: 10),
            const DistrictWidget(),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hint: '${Translate.mobileNumber.tr} *',
              textEditingController: controller.mobileTEC,
              textInputType: TextInputType.phone,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            const IsDefaultSwitchWidget(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 0),
              child: CustomBorderButton(
                color: AppColors.redColor,
                radius: 20,
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
