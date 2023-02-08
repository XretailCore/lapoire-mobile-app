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
  const AddressDetailsForm({Key? key}) : super(key: key);
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
                    textEditingController: controller.firstNameController,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.lastName.tr} *',
                    textEditingController: controller.lastNameController,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hint: '${Translate.addressName.tr} *',
              textEditingController: controller.addressNameController,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hint: '${Translate.streetName.tr} *',
              textEditingController: controller.streetNameController,
              textInputType: TextInputType.name,
              validator: CustomValidator.requiredValidation,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.buildingNumber.tr} *',
                    textEditingController: controller.buildingNumberController,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.floorNumber.tr} *',
                    textEditingController: controller.floorNumberController,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormFieldWidget(
                    hint: '${Translate.apartmentNumber.tr} *',
                    textEditingController: controller.apartmentNumberController,
                    textInputType: TextInputType.name,
                    validator: CustomValidator.requiredValidation,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ZoneWidget(),
            const SizedBox(height: 10),
            const DistrictWidget(),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              hint: '${Translate.mobileNumber.tr} *',
              textEditingController: controller.mobileController,
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
                onTap: () => controller.editAddress(context: context),
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
