import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linktsp_api/linktsp_api.dart';

import '../localization/lanaguages_enum.dart';

class _CustomSharedPrefrenece {
  static final GetStorage _getStorage = GetStorage();
  static const String _userFirstName = 'userFirstName',
      _userLastName = 'userLastName',
      _isActive = 'isActive',
      _subscribeNotifications = 'subscribeNotifications',
      _skipIntro = 'skipIntro',
      _userId = 'userId',
      _userEmail = 'userEmail',
      _appLanguage = 'appLanguage',
      _userMobile = 'userMobile',
      _currentLocation = 'currentLocation',
      _cart = 'cart',
      _zone = 'zone',
      language = 'language';
  _CustomSharedPrefrenece();

  int? get getUserId => _getStorage.read<int>(_userId);
  set setUserId(int? v) => _getStorage.write(_userId, v);
  set setcurrentLocation(Position? v) => _getStorage.write(_currentLocation, v);
  bool get getIsActive => _getStorage.read<bool>(_isActive) ?? false;
  set setIsActive(bool? v) => _getStorage.write(_isActive, v);

  bool get getSubscribeNotifications =>
      _getStorage.read<bool>(_subscribeNotifications) ?? true;
  set setSubscribeNotifications(bool? v) =>
      _getStorage.write(_subscribeNotifications, v);
  bool get getSkipIntro => _getStorage.read<bool>(_skipIntro) ?? false;
  set setSkipIntro(bool? v) => _getStorage.write(_skipIntro, v);

  String get getFirstName => _getStorage.read<String>(_userFirstName) ?? '';
  set setFirstName(String? v) => _getStorage.write(_userFirstName, v);

  String get getUserEmail => _getStorage.read<String>(_userEmail) ?? '';
  set setUserEmail(String? v) => _getStorage.write(_userEmail, v);

  String get getLastName => _getStorage.read<String>(_userLastName) ?? '';
  set setLastName(String? v) => _getStorage.write(_userLastName, v);

  int? get getAppLanguage => _getStorage.read<int>(_appLanguage);
  set setAppLanguage(int? v) => _getStorage.write(_appLanguage, v);

  String get getUserMobile => _getStorage.read<String>(_userMobile) ?? '';
  set setUserMobile(String? v) => _getStorage.write(_userMobile, v);

  CityModel? get getUserZone {
    final city = _getStorage.read(_zone);
    if (city is CityModel?) {
      return city;
    } else {
      return CityModel.fromJson(_getStorage.read(_zone));
    }
  }
  Position? get getcurrentLocation {
    final position = _getStorage.read(_currentLocation);
    if (position is Position?) {
      return position;
    } else {
      return Position.fromMap(position);
    }
  }
  set setUserZone(CityModel? v) => _getStorage.write(_zone, v);
  bool _productsIsEmpty(List<CartSkuModel> products, CartSkuModel product) {
    if (products.isEmpty ||
        products
            .where((element) => element.skuid == product.skuid)
            .toList()
            .isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  int _getIndexOfProduct(List<CartSkuModel> products, CartSkuModel product) {
    return products.indexOf(products
        .where((element) => element.skuid == product.skuid)
        .toList()[0]);
  }

  void addToCart(CartSkuModel product) {
    List<CartSkuModel> products = getAllCart();
    int index = _productsIsEmpty(products, product)
        ? 0
        : _getIndexOfProduct(products, product);
    products.insert(index, product);
    _getStorage.write(_cart, products);
  }

  void updateCart(CartSkuModel product) {
    List<CartSkuModel> products = getAllCart();
    int index = _productsIsEmpty(products, product)
        ? 0
        : _getIndexOfProduct(products, product);
    products.removeWhere((element) => element.skuid == product.skuid);
    products.insert(index, product);
    _getStorage.write(_cart, products);
  }

  List<CartSkuModel> getAllCart() {
    final List? v = _getStorage.read<List>(_cart);
    if (v is List<CartSkuModel>) {
      return v;
    } else {
      return v?.map((e) => CartSkuModel.fromJson(e)).toList() ?? [];
    }
  }

  void updateListToCart(List<CartSkuModel> products) {
    _getStorage.write(_cart, products);
  }

  void getAndRemoveAllCart(List<CartSkuModel> products) {
    _getStorage.write(_cart, products);
  }

  String get getLanguage =>
      _getStorage.read<String>(language) ?? Languages.en.name;
  set setLanguage(String v) => _getStorage.write(language, v);
}

class UserSharedPrefrenceController extends GetxController {
  UserSharedPrefrenceController();
  static final _CustomSharedPrefrenece _customSharedPrefrenece =
      _CustomSharedPrefrenece();

  final Rx<int?> _userId = Rx<int?>(null);
  int? get getUserId => _userId.value = _customSharedPrefrenece.getUserId;

  final Rx<bool?> _userIsActive = Rx<bool?>(false);
  final RxBool _skipIntro = false.obs;
  final Rx<String?> _userFirstName = Rx<String?>(null);
  final Rx<String?> _userLastName = Rx<String?>(null);
  final Rx<String?> _userEmail = Rx<String?>(null);
  final Rx<Position?> _currentLocation = Rx<Position?>(null);
  final Rx<String?> _userMobile = Rx<String?>(null);
  final Rx<String> _language = Rx<String>(Languages.en.name);
  final Rx<bool?> _notificationsSubscription = Rx<bool?>(null);

  final Rx<CityModel?> _currentZone = Rx<CityModel?>(null);

  set setCurrentLocation(Position? v) {
    _customSharedPrefrenece.setcurrentLocation = v;
    _currentLocation.value = v;
  }
  set setUserId(int? v) {
    _customSharedPrefrenece.setUserId = v;
    _userId.value = v;
  }

  bool? get getNotificationsSubscription => _notificationsSubscription.value =
      _customSharedPrefrenece.getSubscribeNotifications;

  set setNotificationsSubscription(bool? v) {
    _customSharedPrefrenece.setSubscribeNotifications = v;
    _notificationsSubscription.value = v;
  }

  final Rx<List<CartSkuModel>?> _allCart = Rx<List<CartSkuModel>?>(null);
  List<CartSkuModel> get getAllCart =>
      _allCart.value = _customSharedPrefrenece.getAllCart();
  void removeCart() {
    List<CartSkuModel> products = _customSharedPrefrenece.getAllCart();
    products.clear();
    _customSharedPrefrenece.getAndRemoveAllCart(products);
  }

  void addToCart(CartSkuModel product) {
    _customSharedPrefrenece.addToCart(product);
  }

  void updateFromCart(CartSkuModel product) {
    _customSharedPrefrenece.updateCart(product);
  }

  void updateCartList(List<CartSkuModel> product) {
    List<CartSkuModel> products = _customSharedPrefrenece.getAllCart();
    _customSharedPrefrenece.updateListToCart(products);
  }

  CityModel? get getCurrentZone =>
      _currentZone.value = _customSharedPrefrenece.getUserZone;

  set setCurrentZone(CityModel? v) {
    _customSharedPrefrenece.setUserZone = v;
    _currentZone.value = v;
  }

  bool? get getUserIsActive => _userIsActive.value;
  set setUserIsActive(bool? v) {
    _customSharedPrefrenece.setIsActive = v;
    _userIsActive.value = v;
  }

  bool? get getSkipIntro =>
      _skipIntro.value = _customSharedPrefrenece.getSkipIntro;
  set setSkipIntro(bool? v) {
    _customSharedPrefrenece.setSkipIntro = v;
    _skipIntro.value = v!;
  }
  Position? get getCurrentLocation {
    _currentLocation.value = _customSharedPrefrenece.getcurrentLocation;
    return _currentLocation.value;
  }
  String get getUserFirstName =>
      _userFirstName.value = _customSharedPrefrenece.getFirstName;
  set setUserFirstName(String? v) {
    _customSharedPrefrenece.setFirstName = v;
    _userFirstName.value = v;
  }

  String get getUserLastName =>
      _userLastName.value = _customSharedPrefrenece.getLastName;
  set setUserLastName(String? v) {
    _customSharedPrefrenece.setLastName = v;
    _userLastName.value = v;
  }

  String? get getUserEmail {
    _userEmail.value = _customSharedPrefrenece.getUserEmail;
    return _userEmail.value;
  }

  set setUserEmail(String? v) {
    _customSharedPrefrenece.setUserEmail = v;
    _userEmail.value = v;
  }

  // int? get getAppLanguage => _customSharedPrefrenece.getAppLanguage;
  // set setAppLanguage(int? v) {
  //   _customSharedPrefrenece.setAppLanguage = v;
  //   _appLanguage.value = v;
  // }

  String get getUserMobile =>
      _userMobile.value = _customSharedPrefrenece.getUserMobile;
  set setUserMobile(String? v) {
    _customSharedPrefrenece.setUserMobile = v;
    _userMobile.value = v;
  }

  bool get isUserIdNull {
    _userId.value = _customSharedPrefrenece.getUserId;
    return _userId.value == null;
  }

  bool get isUser {
    _userId.value = _customSharedPrefrenece.getUserId;
    return _userId.value != null;
  }

  void cacheUserData(
      {int? idUser,
      String? firstName,
      String? lastName,
      String? emailAddress,
      String? mobile,
      bool? isActive}) {
    setUserId = idUser;
    setUserIsActive = isActive;
    setUserFirstName = firstName;
    setUserLastName = lastName;
    setUserEmail = emailAddress;
    setUserMobile = mobile;
  }

  void clearCacheUserData() {
    setUserId = null;
    setUserIsActive = null;
    setUserFirstName = null;
    setUserLastName = null;
    setUserEmail = null;
    setUserMobile = null;
  }

  String get getLanguage =>
      _language.value = _customSharedPrefrenece.getLanguage;
  set setLanguage(String v) {
    _customSharedPrefrenece.setLanguage = v;
    _language.value = v;
  }
}
