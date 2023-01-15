import 'package:form_field_validator/form_field_validator.dart';

import '../localization/translate.dart';

class CustomValidator {
  static final requiredValidation = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
      ]),
      userNameValidation = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
      ]),
      multiLineTextValidation = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
      ]),
      fullNameValidation = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
      ]),
      emailValidation = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
        EmailValidator(errorText: Translate.invalidEmail.tr),
      ]),
      passwordValidator = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
      ]),
      _rePasswordValidator = MatchValidator(errorText: Translate.notMatched.tr),
      mobileValidator = MultiValidator([
        RequiredValidator(errorText: Translate.required.tr),
      ]);
  String? emptyFieldValidation(String value) {
    if (value.isEmpty) {
      return Translate.required.tr;
    }
    return null;
  }

  static String? rePasswordValidator(
          {required String password, required String? rePassword}) =>
      (CustomValidator._rePasswordValidator
          .validateMatch(password, rePassword ?? ''));
}
