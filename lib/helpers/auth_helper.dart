import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

typedef AuthCredential = ({
  OAuthCredential credential,
  String displayName,
  String photoUrl,
});

class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}

class AuthHelper {
  final auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      final cred = await _getCredential();
      if (cred == null) return;

      await auth.signInWithCredential(cred.credential);
      final user = auth.currentUser;

      if (cred.displayName.isNotEmpty) {
        await user?.updateDisplayName(cred.displayName);
      }
      if (cred.photoUrl.isNotEmpty) {
        await user?.updatePhotoURL(cred.photoUrl);
      }
    } catch (e, st) {
      throw AuthException('$e\n$st');
    }
  }

  Future<AuthCredential?> _getCredential() async {
    if (Platform.isAndroid) {
      final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
      final account = await googleSignIn.signIn();

      if (account == null) return null;
      final auth = await account.authentication;

      return (
        credential: GoogleAuthProvider.credential(
          accessToken: auth.accessToken,
          idToken: auth.idToken,
        ),
        displayName: account.displayName ?? '',
        photoUrl: account.photoUrl ?? '',
      );
    } else {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      try {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        );

        return (
          credential: OAuthProvider("apple.com").credential(
            idToken: appleCredential.identityToken,
            rawNonce: rawNonce,
            accessToken: appleCredential.authorizationCode,
          ),
          displayName: appleCredential.givenName ?? '',
          photoUrl: '',
        );
      } on SignInWithAppleAuthorizationException catch (e) {
        if (e.code == AuthorizationErrorCode.canceled) return null;
        rethrow;
      }
    }
  }

  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
