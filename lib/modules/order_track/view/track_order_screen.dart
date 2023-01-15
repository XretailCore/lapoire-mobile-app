import 'package:dotted_line/dotted_line.dart';
import '../../../core/components/imtnan_loading_widget.dart';
import '../../../core/utils/theme.dart';
import '../../../core/components/appbar_widget.dart';
import '../../../core/localization/translate.dart';
import '../../../core/components/custom_text.dart';
import '../controllers/track_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linktsp_api/linktsp_api.dart';

class TrackOrderScreen extends GetView<TrackOrderController> {
  const TrackOrderScreen({Key? key}) : super(key: key);
  @override
  build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarWidget(title: Translate.trackYourOrder.tr),
      body: controller.obx(
        (data) => Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Center(
                      child: Image.asset(
                    "assets/images/track_order_image.png",
                    height: .3.sh,
                  )),
                ),
                Expanded(
                    child: ListView.separated(
                  itemCount: data!.items!.length,
                  itemBuilder: (context, itemIndex) => TrackOrderItemWidget(
                    lastItem: (itemIndex == data.items!.length - 1)
                        ? controller.lastItem = true
                        : controller.lastItem = false,
                    model: data.items![itemIndex],
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 0);
                  },
                )),
              ],
            ),
          ),
        ),
        onLoading: const CustomLoadingWidget(),
      ),
    );
  }
}

class TrackOrderItemWidget extends StatelessWidget {
  const TrackOrderItemWidget({this.model, Key? key, this.lastItem})
      : super(key: key);

  final TrackOrderItemModel? model;
  final bool? lastItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: .15.sw),
              _dottedAndCircleWidget(),
              const SizedBox(width: 20),
              Expanded(
                child: _titleColumnWidget(),
                // flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dottedAndCircleWidget() {
    return Column(
      children: [
        Container(
          width: 15.0,
          height: 15.0,
          decoration: BoxDecoration(
            color: CustomThemes.appTheme.primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        Visibility(
          visible: (lastItem ?? false) ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DottedLine(
              dashLength: 5,
              dashGapLength: 2,
              lineThickness: 1,
              dashColor: CustomThemes.appTheme.primaryColor,
              direction: Axis.vertical,
              lineLength: 75,
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleColumnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              '${Translate.status.tr} :',
              style: TextStyle(
                color: CustomThemes.appTheme.primaryColor,
              ),
              // style: AppStyle.Orders_card_label_dark,
            ),
            const SizedBox(width: 10),
            CustomText(
              model!.status ?? '',
              style: TextStyle(
                color: CustomThemes.appTheme.primaryColor,
              ),
              // style: AppStyle.Orders_card_label_dark,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            CustomText(
              '${Translate.date.tr} :',
              style: TextStyle(
                color: CustomThemes.appTheme.primaryColor,
              ),
              // // style: AppStyle.Orders_card_label_dark,
            ),
            const SizedBox(width: 10),
            CustomText(
              model!.date!.day.toString() +
                  '/' +
                  model!.date!.month.toString() +
                  '/' +
                  model!.date!.year.toString(),
              style: TextStyle(
                color: CustomThemes.appTheme.primaryColor,
              ),
              // style: AppStyle.Orders_card_label_dark,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            CustomText(
              '${Translate.time.tr} :',
              style: TextStyle(
                color: CustomThemes.appTheme.primaryColor,
              ),
              // // style: AppStyle.Orders_card_label_dark,
            ),
            const SizedBox(width: 10),
            CustomText(
              DateFormat('h:mm a').format(model!.date ?? DateTime.now()),
              style: TextStyle(color: CustomThemes.appTheme.primaryColor),
              // style: AppStyle.Orders_card_label_dark,
            ),
          ],
        ),
      ],
    );
  }
}
