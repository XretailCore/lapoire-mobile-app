import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/theme.dart';
import '../controller/my_addresses_controller.dart';
import '../widgets/empty_address_widget.dart';
import '../widgets/my_addresses_item_widget.dart';

class MyAddressesScreen extends GetView<MyAddressesController> {
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTitledAppBar(title: Translate.myAddresses.name.tr),
      body: controller.obx(
        (data) {
          final addresses = data ?? [];
          return addresses.isEmpty
              ? const EmptyAddressesWidget()
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(15),
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 10),
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final selectedAddress = addresses.elementAt(index);
                          return AddressBookItemWidget(
                            address: selectedAddress,
                            editAddressAction: () =>
                                controller.editAddressAction(selectedAddress),
                            deleteAddressAction: () =>
                                controller.deleteAddressAction(context,
                                    addresses: addresses,
                                    selectedAddress: selectedAddress),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                        enabled: true,
                        color: CustomThemes.appTheme.primaryColor,
                        onTap: controller.addNewAddressAction,
                        textColor: Colors.white,
                        title: Translate.addNewAddress.name.tr,
                      ),
                    )
                  ],
                );
        },
        onEmpty: const EmptyAddressesWidget(),
        onLoading: const CustomLoadingWidget(),
        onError: (e) => CustomErrorWidget(
          errorText: e,
          onReload: controller.getAddresses,
        ),
      ),
    );
  }
}
