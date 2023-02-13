import 'package:flutter/material.dart';
import 'package:imtnan/core/components/imtnan_loading_widget.dart';
import '../utils/theme.dart';

void openLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: Dialog(
              alignment: Alignment.center,
              backgroundColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius: BorderRadius.circular(15)),
                    child: const SizedBox(
                      width: 80,
                      height: 80,
                      child: Center(child: CustomLoadingWidget()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}
