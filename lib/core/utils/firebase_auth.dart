import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'strings.dart';

class UserSocialData {
  final String? firstName, lastName, email, socialCode, socialType, appleId;

  UserSocialData(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.socialCode,
      this.appleId,
      required this.socialType});
}

class SocialAuth {
  static final instance = SocialAuth();
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<UserSocialData?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final userSocialData = UserSocialData(
          email: googleUser.email,
          firstName: googleUser.displayName,
          lastName: '',
          socialCode: googleUser.id,
          socialType: 'Google');
      return userSocialData;
    } else {
      return null;
    }
  }

  Future<UserSocialData?> signInWithAppleId() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final userSocialData = UserSocialData(
          email: credential.email,
          firstName: credential.givenName,
          lastName: '',
          socialCode: '',
          appleId: credential.userIdentifier,
          socialType: appleIdSocial);
      return userSocialData;
    } catch (e) {
      return null;
    }
  }

  Future<GoogleSignInAccount?> signoutWithGoogle() async {
    return await googleSignIn.signOut();
  }

  Future<UserSocialData?> signInWithFacebook() async {
    final LoginResult result =
        await FacebookAuth.instance.login(loginBehavior: LoginBehavior.webOnly);
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      final userSocialData = UserSocialData(
          email: userData['email'],
          firstName: userData['name'],
          lastName: '',
          socialCode: userData['id'],
          socialType: 'Facebook');
      return userSocialData;
    }
    return null;
  }

  Future<void> signoutWithFacebook() async {
    return await FacebookAuth.instance.logOut();
  }

  Future<void> signoutFromAllSocialMedia() async {
    try {
      await Future.wait([signoutWithFacebook(), signoutWithGoogle()]);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
