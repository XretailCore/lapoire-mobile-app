import 'package:dropdown_search/dropdown_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imtnan/core/utils/theme.dart';

import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/components/appbar_widget.dart';
import '../../../core/utils/helper_functions.dart';
import '../widgets/header_profile_widget.dart';
import 'package:linktsp_api/linktsp_api.dart' hide Size;
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/validator.dart';
import '../controllers/profile_controller.dart';
import '../widgets/gender_radio_group_widget.dart';
import '../../../core/components/text_button_widget.dart';
import '../../../core/components/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: primaryColor,
        ));
    return Scaffold(
      appBar: AppBarWidget(title: Translate.profile.tr),
      backgroundColor: Colors.white,
      body: controller.obx(
        (user) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderProfileWidget(),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormFieldWidget(
                                  textEditingController:
                                      controller.firstNameTEC,
                                  hint: '${Translate.firstName.tr} *',
                                  textInputType: TextInputType.name,
                                  validator: CustomValidator.userNameValidation,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormFieldWidget(
                                  textEditingController: controller.lastNameTEC,
                                  hint: '${Translate.lastName.tr} *',
                                  textInputType: TextInputType.name,
                                  validator: CustomValidator.userNameValidation,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormFieldWidget(
                            textEditingController: controller.emailTEC,
                            hint: '${Translate.emailAddress.tr} *',
                            textInputType: TextInputType.emailAddress,
                            validator: CustomValidator.emailValidation,
                          ),
                          const SizedBox(height: 10),
                          TextFormFieldWidget(
                            textEditingController: controller.mobileTEC,
                            hint: '${Translate.mobileNumber.tr} *',
                            textInputType: TextInputType.phone,
                            validator: CustomValidator.mobileValidator,
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                '${Translate.zone.tr} :',
                                style: TextStyle(color: primaryColor),
                              ),
                              const SizedBox(height: 8),
                              DropdownSearch<CityModel>(
                                itemAsString: (item) {
                                  return item?.name ?? "";
                                },
                                showSearchBox: true,
                                dropdownSearchTextAlign: TextAlign.center,
                                dropdownButtonBuilder: (_) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: primaryColor,
                                    ),
                                  );
                                },
                                emptyBuilder: (_, __) {
                                  return Center(
                                    child: CustomText(
                                      Translate.noDataFound.tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                    ),
                                  );
                                },
                                filterFn: (city, filter) =>
                                    HelperFunctions.cityFilterByName(
                                        filter ?? '', city?.name ?? ''),
                                onPopupDismissed: () {
                                  controller.searchZoneTEController.text = '';
                                },
                                searchFieldProps: TextFieldProps(
                                  controller: controller.searchZoneTEController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(5),
                                    hintText: Translate.searchHere.tr,
                                    hintStyle: const TextStyle(fontSize: 13),
                                    focusedBorder: const OutlineInputBorder(),
                                    enabledBorder: const OutlineInputBorder(),
                                  ),
                                ),
                                selectedItem:
                                    controller.setCurrentCity(user?.city),
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: primaryColor),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.red),
                                  ),
                                ),
                                dropdownBuilder: (context, item) {
                                  if ((controller.selectedCity.value?.id ??
                                          0) ==
                                      0) {
                                    return CustomText(
                                      Translate.selectYourZone.tr,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13, color: primaryColor),
                                    );
                                  } else {
                                    return CustomText(
                                      item?.name ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13, color: primaryColor),
                                    );
                                  }
                                },
                                onChanged: (city) {
                                  controller.selectedCity.value = city;
                                },
                                items: controller.cities,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomText(
                            '${Translate.birthdate.tr} :',
                            style: TextStyle(color: primaryColor),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    controller.chooseDate(context);
                                  },
                                  child: Container(
                                    decoration: decoration,
                                    height: 40,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              controller.selectedDate.value.day
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: CustomThemes
                                                      .appTheme.primaryColor),
                                            ),
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.sortDown,
                                            size: 14,
                                            color: CustomThemes
                                                .appTheme.primaryColor,
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    controller.chooseDate(context);
                                  },
                                  child: Container(
                                    decoration: decoration,
                                    height: 40,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              controller
                                                  .selectedDate.value.month
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: CustomThemes
                                                      .appTheme.primaryColor),
                                            ),
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.sortDown,
                                            size: 14,
                                            color: CustomThemes
                                                .appTheme.primaryColor,
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    controller.chooseDate(context);
                                  },
                                  child: Container(
                                    decoration: decoration,
                                    height: 40,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              controller.selectedDate.value.year
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: CustomThemes
                                                      .appTheme.primaryColor),
                                            ),
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.sortDown,
                                            size: 14,
                                            color: CustomThemes
                                                .appTheme.primaryColor,
                                          ),
                                        ],
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GenderRadioGroupWidget(
                            defaultGender:
                                controller.selectedGender == Gender.MALE
                                    ? 0
                                    : 1,
                            children: [Translate.male.tr, Translate.female.tr],
                            onChanged: controller.onGenderChanged,
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: TextButtonWidget(
                              minimumSize: const Size(190, 35),
                              text: Translate.save.tr,
                              onPressed: () => controller.onTapSave(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (v) => CustomErrorWidget(
          errorText: v,
          onReload: controller.init,
        ),
      ),
    );
  }
}
