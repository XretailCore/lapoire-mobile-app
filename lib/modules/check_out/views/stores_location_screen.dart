import 'package:imtnan/core/components/custom_appbar.dart';
import '../../../core/components/custom_text.dart';
import '../../../core/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/custom_shared_prefrenece.dart';
import '../../../core/utils/theme.dart';
import '../controllers/store_location_controller.dart';
import '../enum/stores_enum.dart';
import '../widgets/checkout_title_divider_widget.dart';
import '../widgets/container_widget.dart';
import '../widgets/custom_stepper_widget.dart';
import '../widgets/stores_location_widget.dart';

class StoresLocationScreen extends GetView<StoreLocationController> {
  const StoresLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Translate.checkout.tr, showBackButton: true,showAction: false,onTap: (){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Get.back();
      }),
      body: ContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomStepperWidget(currentIndex: 0),
            const SizedBox(height: 10),
            CheckOutTitleDividerWidget(
                title: Translate.selectCollectingStore.tr),
            const SizedBox(height: 10),
            ChoiceFilterStoresWidget(
              onChanged: (store) {
                final userSharedPref =
                    Get.find<UserSharedPrefrenceController>();
                controller.getStores(
                    position: userSharedPref.getCurrentLocation,
                    storeFilter: store);
              },
            ),
            const SizedBox(height: 15),
            Expanded(
              child: controller.obx(
                (v) => StoresLocationsWidget(
                  stores: v ?? [],
                ),
                onError: (error) => Center(
                  child: CustomText(
                    error,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceFilterStoresWidget extends StatefulWidget {
  const ChoiceFilterStoresWidget({
    Key? key,
    this.currentStore = Stores.nearstStores,
    required this.onChanged,
  }) : super(key: key);
  final Stores currentStore;
  final void Function(Stores store) onChanged;

  @override
  State<ChoiceFilterStoresWidget> createState() =>
      _ChoiceFilterStoresWidgetState();
}

class _ChoiceFilterStoresWidgetState extends State<ChoiceFilterStoresWidget> {
  late Stores selectedStore;

  @override
  void initState() {
    super.initState();
    selectedStore = widget.currentStore;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selectedStore == Stores.nearstStores
            ? AppColors.redColor
            : CustomThemes.appTheme.primaryColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedStore = Stores.nearstStores;
                  widget.onChanged(selectedStore);
                });
              },
              child: CustomText(
                Translate.nearestStores.tr.capitalizeFirst,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedStore = Stores.allStores;
                  widget.onChanged(selectedStore);
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: selectedStore == Stores.allStores
                      ? AppColors.redColor
                      : CustomThemes.appTheme.primaryColor,
                ),
                child: CustomText(
                  Translate.allStores.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
