import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:linktsp_api/core/models/admin_model.dart';

// todo : change urls
const String currency = 'EGP',
    appIdAndroid = 'com.Linktsp.Lapoire',
    appIdIOs = '6443763789',
    websiteUrl = 'http://193.42.121.138:5002',
    appUrl = "https://lapoire.page.link/start",
    appUrlIOs = "itms-apps://itunes.apple.com/app/id$appIdIOs";
// Live Domain
const String liveDomain = "http://193.42.121.138:5002";
// Test Domain
const String testDomain = "http://193.42.121.138:5002";

const String domain = (kDebugMode || kProfileMode) ? testDomain : liveDomain;

final AdminModel admin = AdminModel(
    email: '69A4788C-2E32-4CB5-A00A-477DD3B3FC72',
    password: 'C19BCDBD-1A8E-4F8F-B30E-B721582E64EC');
const int aboutUsId = 5;
const int privacyPolicyId = 6;
const int deliveryPolicyId = 9;
const int termsAndConditionId = 4;
const int fawryPaymentId = 10;
const String appleIdSocial = 'appleid';

const gradientColors = [
  Color(0xFF17726D),
  Color(0xFF1D9089),
  Color(0xFF36BEB2),
  Color(0xFF4FD2C2)
];
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class Arguments {
  static String skuId = 'skuId';
  static String quantity = 'quantity';
  static String categoryAppBarTitle = 'catAppBartitle';
  static String tabIndex = 'tabIndex';
  static String categoryId = 'categoryId';
  static String categoryName = 'categoryName';
  static String addressId = 'addressId';
  static String addressDetails = 'addressDetails';
  static String orderId = 'orderId';
  static String orderNo = 'orderNo';
  static String productCode = 'productCode';
  static String productDetails = 'productDetails';
  static String contentPageId = 'contentPageId';
  static String contentPageTitle = 'contentPageTitle';
  static String filterOptions = 'filterOptions';
  static String lat = 'lat';
  static String lng = 'lng';
  static String address = 'address';
  static String filterModel = 'filterModel';
  static String addressModel = 'addressModel';
  static String mapPageName = 'mapPageName';
  static String isMapAction = 'isMapAction';
  static String isCheckoutAddress = 'isCheckoutAddress';
  static String selectedZoneId = 'selectedZoneId';
  static String isCheckoutCancel = "isCheckoutCancel";
  static String paymentFrameModel = 'paymentFrameModel';
  static String paymentOptionId = 'paymentOptionId';
  static String finalAmount = 'finalAmount';
  static String merchantGuid = 'merchantGuid';
}
