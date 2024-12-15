
import 'dart:developer';

import 'package:chateo/core/services/cache_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _fireStore;

  const AuthRepo(this._firebaseAuth, this._fireStore);

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String phoneNumber = await _fireStore.collection("users").doc(userCredential.user!.uid).get().then((value) {
        CacheService.putData(key: CacheServiceConstants.phoneNumber, value: value.data()!["phoneNumber"]);
        return value.data()!["phoneNumber"];
      });
      CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
      CacheService.putData(key: CacheServiceConstants.phoneNumber, value: phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithToken(String token) async {
    try {
      await _firebaseAuth.signInWithCustomToken(token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _fireStore.collection("users").doc(credential.user!.uid).set({
        "name": name,
        "email": email,
        "uid": credential.user!.uid,
        "phoneNumber": phoneNumber,
        "loginType": "email",
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var userCredential = await _firebaseAuth.signInWithCredential(credential);
      CacheService.putData(key: CacheServiceConstants.token, value: userCredential.credential!.token);
      CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
      await _fireStore.collection("users").doc(userCredential.user!.uid).set({
        "name": userCredential.user!.displayName,
        "email": userCredential.user!.email,
        "uid": userCredential.user!.uid,
        "phoneNumber": userCredential.user!.phoneNumber,
        "loginType": "google",
      });
      CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
      CacheService.putData(key: CacheServiceConstants.phoneNumber, value: userCredential.user!.phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = 'xxxx';
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
          await _firebaseAuth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
