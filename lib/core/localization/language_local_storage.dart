import 'package:get_storage/get_storage.dart';

class LocalStorage {
  // write to disk
  void saveLanguageToDisck(String language) async {
    await GetStorage().write("lang", language);
  }

  // read from disk
  Future<String> get getSelectedLanguage async =>
      await GetStorage().read("lang");
}
