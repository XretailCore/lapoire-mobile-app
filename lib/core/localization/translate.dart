import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum Translate {
  appName,
  home,
  menu,
  wishlist,
  categories,
  profile,
  myCart,
  myOrders,
  myAddresses,
  settings,
  aboutUs,
  contactUs,
  stores,
  privacyPolicy,
  deliveryAndReturnPolicy,
  signInAndSignUp,
  signOut,
  language,
  deliverTo,
  change,
  deliverHere,
  selectLocation,
  seeAll,
  newArrivals,
  orderNow,
  bestSeller,
  searchHere,
  enterYourSearch,
  egp,
  allPricesIncudeVatDetails,
  productCode,
  skuCode,
  addReview,
  size,
  chooseSize,
  outOfStock,
  deliveredWithin,
  anOrderMayBeDeliveredLatelyManyMinutesInCaseRushHours,
  description,
  details,
  reviews,
  brand,
  allReviews,
  successed,
  error,
  pleaseAgreeOnTheTermsAndConditionsOfTheApp,
  changePassword,
  currentPassword,
  newPassword,
  confirmYourPassword,
  confirmPasswordIsNotMatching,
  forgetPassword,
  forgetPasswordText,
  enterTheMobileNumberAssociatedWithYourAccount,
  mobile,
  send,
  submit,
  firstName,
  lastName,
  emailAddress,
  mobileNumber,
  place,
  birthdate,
  male,
  female,
  save,
  password,
  signIn,
  signUp,
  orSignInUsing,
  donotHaveAccount,
  termsOfService,
  verifyYourPhoneNumber,
  enterYourOTPCodeHere,
  verify,
  didntReceiveOtpCode,
  resend,
  required,
  invalidEmail,
  invalidMobile,
  notMatched,
  passwordMustBeAtLeast8DigitsLong,
  passwordMustHaveAtLeastOneSpecialCharacter,
  addressHasBeenSavedSuccessfuly,
  addressDetails,
  addressName,
  streetName,
  buildingNumber,
  floorNumber,
  apartmentNumber,
  postalCode,
  selectItemType,
  setAsDefault,
  failed,
  checkout,
  yourBasketIsEmpty,
  yourWishlistIsEmpty,
  total,
  cartBasedDiscount,
  itemsPrice,
  noSubCategories,
  helloSelectYourZone,
  chooseYourLocationToStartEnjoyingOurDeliveringService,
  selectYourZone,
  workingHours7AMTo11Pm,
  prebooking,
  addToBasket,
  buyNow,
  freshAndDailyBakedPatisserie,
  fastDeliveryToYourPlace,
  account,
  subscribeToOurNewsletter,
  notifications,
  others,
  rateTheApp,
  joinOurNewsletterToGetOurLatestNewsAndUpdates,
  subscribe,
  retry,
  rejected,
  transactionFailed,
  goToHomePage,
  confirmation,
  thankYouForYourOrder,
  yourOrderNumberIs,
  continueShopping,
  userNotSelected,
  yourOrderHasBeenPlaced,
  orderCode,
  trackYourOrder,
  creditCard,
  addresses,
  newAddress,
  next,
  homeDelivery,
  getYourProductDeliveredToYourHomeSelectYourAddressToDeliverItToYourDoor,
  useCoupon,
  selectAPaymentMethod,
  paymentsMethod,
  yourItems,
  confirm,
  selectCollectingStore,
  nearestStores,
  allStores,
  additionalFees,
  delivery,
  payment,
  summary,
  enterCouponCode,
  apply,
  clear,
  shippingInformation,
  yourOrderWillBeDeliveredWithinMinMaxBusinessDays,
  deliveredWithinMinMaxBusinessDays,
  yourAddress,
  itemsFound,
  price,
  sortBy,
  orderDetails,
  addFeedback,
  cancel,
  cancelOrder,
  cancelOrderNumberMessage,
  reason,
  message,
  items,
  orderNumber,
  date,
  totalAmount,
  status,
  cancelOrderValidationMsg,
  cancelOrderSuccessMsg,
  feedbackSuccessMsg,
  orderNotFound,
  neew,
  deleteAddressSuccessMsg,
  emptyAddressses,
  emptyAddresssesMessage,
  addNewAddress,
  defaultAddress,
  deleteAddress,
  deleteAddressConfirm,
  no,
  yes,
  delete,
  edit,
  noOrdersFound,
  cancelled,
  track,
  filter,
  writeReview,
  rateProduct,
  productHasBeenRatedSuccessfully,
  fieldsRequired,
  findYourNearestBranch,
  searchByCurrentLocation,
  searchByCity,
  noStores,
  thereAreNoStoresHere,
  errorOccurredWhileGettingCities,
  km,
  noItems,
  iHaveReadAndAgreedOnTheTermsAndConditionsOfTheApp,
  minutes,
  pleaseChooseFilterCriteria,
  priceLowToHigh,
  priceHighToLow,
  bestSellers,
  productNameAZ,
  productNameZA,
  outOfNStock,
  productHasBeenAddedSusccessfully,
  yourLocationIsOutOfZoneRange,
  time,
  close,
  pleaseSelectSize,

  myAccount,
  addressBook,
  share,
  rateApp,
  logOut,
  hiThere,
  or,
  youAlreadyHaveAnAccount,
  register,
  weAreGettingYourOrderReadyToBeShippedWeWillNotifyYouWithDeliveryDate,
  changeYourPassword,
  enterTheCodeToVerifyYourPhone,
  verificationCodeHasBeenSentTo,
  orderDate,
  quantity,
  featuresAndBenefits,
  ingredientsAndHowToUse,
  turnOnGps,
  availabilityInStock,
  relatedItems,
  recentItems,
  chooseOneOfThesePaymentMethods,
  doYouToPayWithYourIcons,
  points,
  yourCurrentBalanceIsNPoints,
  post,
  describeYourExperience,
  reload,
  freeGift,
  ratings,
  outOf,
  invalidPassword,
  loyaltyPoints,
  noReviewsYet,
  prebookingPolicy,
  agree,
  iAgree,
  pleaseCompleteYourAccountFirst,
  underDevelopment,
  thisItemWillBeAvailableAt,
  areYouWantToDeleteTheItemFromWishlist,
  areYouWantToDeleteTheItemFromBag,
  itemAddedToWishlist,
  itemRemovedFromWishlist,
  cashOnDeliveryFees,
  shipmentfees,
  address,
  buyNowTotal,
  orderNo,
  orderSummary,
  itemAddedSuccessfullyToBag,
  youAreNotLoggedInYet,
  done,
  fawryId,
  selectCity,
  deleteAccount,
  deactivateAccount,
  accountDeletedSuccessfully,
  accountDeactivatedSuccessfully,
  areYouWantToDeleteYourAccount,
  areYouWantToDeactivateYourAccount,
  update,
  cancelbtn,
  thereIsaNewVersion,
  emailAddressOrPhoneNumber,
  errorOccurred,
  district,
  whoBoughtProducts,
  whoViewedProduct,
  zone,
  offers,
  noInternetConnection,
  checkYourInternetConnection,
  noDataFound,
  ordersThisMonth
}

extension TR on Translate {
  String get tr => name.tr;
}

extension TrParams on Translate {
  String trParams({Map<String, String> params = const {}}) =>
      name.trParams(params);
}
