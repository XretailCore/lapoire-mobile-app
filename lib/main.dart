import 'dart:async';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/localization/custom_translations.dart';
import 'core/localization/lanaguages_enum.dart';
import 'core/localization/translate.dart';
import 'core/utils/firebase_notification.dart';
import 'core/utils/initial_binding.dart';
import 'core/utils/routes.dart';
import 'core/utils/strings.dart';
import 'core/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final facebookAppEvents = FacebookAppEvents();
  facebookAppEvents.setAdvertiserTracking(enabled: true);

  await FirebaseNotification.init();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) {
        return GetMaterialApp(
          translations: CustomTranslations(),
          scaffoldMessengerKey: scaffoldMessengerKey,
          supportedLocales: [
            Locale(Languages.ar.name),
            Locale(Languages.en.name),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(Languages.ar.name),
          fallbackLocale: Locale(Languages.ar.name),
          popGesture: Get.isPopGestureEnable,
          debugShowCheckedModeBanner: false,
          title: Translate.appName.tr,
          theme: CustomThemes.lightThemeData,
          initialBinding: InitialBinding(),
          getPages: Routes.instance.getScreens(),
        );
      },
    );
  }
}
