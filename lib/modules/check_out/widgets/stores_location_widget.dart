import 'package:dotted_line/dotted_line.dart';
import 'package:imtnan/core/utils/app_colors.dart';
import 'package:imtnan/modules/check_out/widgets/store_location_widget.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/localization/translate.dart';
import '../controllers/locations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/linktsp_api.dart' hide Size;
import '../controllers/store_location_controller.dart';

class StoresLocationsWidget extends GetView<StoreLocationController> {
  const StoresLocationsWidget(
      {Key? key, this.isEnableEdit = false, required this.stores})
      : super(key: key);
  final bool isEnableEdit;
  final List<StoreModel> stores;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreLocationController>(
      builder: (_) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: stores.length,
              itemBuilder: (_, index) {
                final store = stores.elementAt(index);
                return Column(
                  children: [
                    StoreLocationWidget(
                      title: store.name ?? '',
                      description: store.description ?? '',
                      phone: store.mobile ?? store.telephone ?? '',
                      latitude: store.latitude ?? 0,
                      longitude: store.longitude ?? 0,
                      isSelected: Locations.storeId == store.id,
                      onTap: () async {
                        await controller.onTapSelectStore(context, index, store);
                      },
                    ),
                    index!=stores.length-1?const DottedLine(dashColor: AppColors.redColor):const SizedBox()
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CustomBorderButton(
              radius: 20.0,
              color: Locations.storeId != null ? AppColors.redColor : Colors.grey,
              title: Translate.next.tr,
              onTap: Locations.storeId != null
                  ? () => controller.onTapNext(context)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
