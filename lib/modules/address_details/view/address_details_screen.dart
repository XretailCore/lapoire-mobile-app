import '../../../core/components/imtnan_loading_widget.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/localization/translate.dart';
import '../controllers/address_details_controller.dart';
import '../widgets/address_details_form.dart';
import '../widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressDetailsScreen extends GetView<AddressDetailsController> {
  const AddressDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTitledAppBar(title: Translate.addressDetails.tr),
      body: controller.obx(
        (zones) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              const MapWidget(),
              AddressDetailsForm(zones: zones ?? []),
            ],
          ),
        ),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.init,
        ),
      ),
    );
  }
}
