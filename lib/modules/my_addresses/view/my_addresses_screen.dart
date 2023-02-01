import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_error_widget.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/utils/app_colors.dart';
import '../controller/my_addresses_controller.dart';
import '../widgets/empty_address_widget.dart';
import '../widgets/my_addresses_item_widget.dart';

class MyAddressesScreen extends GetView<MyAddressesController> {
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: Translate.addressBook.name.tr, showBackButton: true),
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
                          return Column(
                            children: [
                              AddressBookItemWidget(
                                address: selectedAddress,
                                editAddressAction: () => controller
                                    .editAddressAction(selectedAddress),
                                deleteAddressAction: () =>
                                    controller.deleteAddressAction(context,
                                        addresses: addresses,
                                        selectedAddress: selectedAddress),
                              ),
                              index != addresses.length - 1
                                  ? const Padding(
                                      padding: EdgeInsets.only(top: 16.0),
                                      child: DottedLine(
                                          dashColor: AppColors.redColor),
                                    )
                                  : const SizedBox()
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: CustomBorderButton(
                        enabled: true,
                        radius: 20,
                        color: AppColors.redColor,
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
