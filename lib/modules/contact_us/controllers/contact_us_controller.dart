// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linktsp_api/data/exception_api.dart';
import 'package:linktsp_api/linktsp_api.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/localization/translate.dart';
import '../../../core/utils/helper_functions.dart';

class ContactUsController extends GetxController
    with StateMixin<List<ContactInfoModel>> {
  @override
  void onInit() {
    super.onInit();
    getContactInfo();
  }

  launchUrl({required String url, required BuildContext context}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        HelperFunctions.customSnackBar(message: Translate.error.name.tr),
      );
      throw 'Could not launch $url';
    }
  }

  launchMailto(String mail) async {
    final Uri param = Uri(scheme: 'mailto', path: mail);
    String urlF = param.toString();
    if (await canLaunch(urlF)) {
      await launch(urlF);
    }
  }

  Future<void> getContactInfo() async {
    change(null, status: RxStatus.loading());
    try {
      final contactInformations =
          await LinkTspApi.instance.menu.getContactInfo();
      change(contactInformations, status: RxStatus.success());
    } on ExceptionApi catch (e) {
      change(null, status: RxStatus.error(e.message));
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}

ContactInfoModel? getSelectedContactInfo(
    List<ContactInfoModel>? contactsInfo, int selectedContact) {
  try {
    return contactsInfo?.firstWhere(
      (element) => element.socialType == selectedContact,
    );
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
