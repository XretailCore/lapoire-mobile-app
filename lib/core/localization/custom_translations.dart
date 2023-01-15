import 'package:get/get.dart';

import 'lanaguages_enum.dart';
import 'languages/ar.dart';
import 'languages/en.dart';

class CustomTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        Languages.en.name: LanguageJson.en,
        Languages.ar.name: LanguageJson.ar,
      };
}

class LanguageJson {
  static Map<String, String> get en => getEnglishTranslation();
  static Map<String, String> get ar => getArabicTranslation();
}
