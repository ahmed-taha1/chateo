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
      String phoneNumber = await _fireStore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get()
          .then((value) {
        CacheService.putData(
            key: CacheServiceConstants.phoneNumber,
            value: value.data()!["phoneNumber"]);
        return value.data()!["phoneNumber"];
      });
      CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
      CacheService.putData(
          key: CacheServiceConstants.phoneNumber, value: phoneNumber);
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
      UserCredential credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
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

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var userCredential = await _firebaseAuth.signInWithCredential(credential);
      CacheService.putData(
          key: CacheServiceConstants.userId, value: userCredential.user!.uid);
      if (await _fireStore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get()
          .then((value) => value.exists)) {
        String? phoneNumber = await _fireStore
            .collection("users")
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          return value.data()!["phoneNumber"];
        });
        if (phoneNumber == null || phoneNumber.isEmpty) {
          return false;
        }
        CacheService.putData(
            key: CacheServiceConstants.phoneNumber, value: phoneNumber);
        CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
        return true;
      } else {
        await _fireStore.collection("users").doc(userCredential.user!.uid).set({
          "name": userCredential.user!.displayName,
          "email": userCredential.user!.email,
          "uid": userCredential.user!.uid,
          "phoneNumber": "",
          "loginType": "google",
        });
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isPhoneNumberExists(String phoneNumber) async {
    try {
      var users = await _fireStore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      return users.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addPhoneNumberToGoogleAccount(String userId,
      String phoneNumber) async {
    try {
      await _fireStore.collection("users").doc(userId).update({
        "phoneNumber": phoneNumber,
      });
      CacheService.putData(
          key: CacheServiceConstants.phoneNumber, value: phoneNumber);
      CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    if(await isPhoneNumberExists(phoneNumber)){
      var user = await _fireStore.collection("users").where("phoneNumber", isEqualTo: phoneNumber).get().then((value) => value.docs[0]);
      if(user.data()["loginType"] != "phone"){
        throw Exception("Phone number already exists with another account type");
      }
    }
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential authCred) {
        return;
      },
      verificationFailed: (FirebaseException e) {
        throw e;
      },
      codeSent: (String verificationId, int? resendToken) async {
         await CacheService.putData(key: CacheServiceConstants.tempOtpToken, value: verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        await CacheService.putData(key: CacheServiceConstants.tempOtpToken, value: verificationId);
      },
    );
  }

  Future<void> verifyOtp(String otp) async {
    try {
      String? verificationId = CacheService.getData(key: CacheServiceConstants.tempOtpToken);
      if (verificationId == null) {
        throw Exception("Verification id is null");
      }
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      var userCred = await _firebaseAuth.signInWithCredential(credential);
      // check if the otp is correct
      if (userCred.user == null) {
        throw Exception("Invalid OTP");
      }

      if (!await _fireStore.collection("users").doc(userCred.user!.uid).get().then((value) => value.exists)) {
        await _fireStore.collection("users").doc(userCred.user!.uid).set({
          "uid": userCred.user!.uid,
          "phoneNumber": userCred.user!.phoneNumber,
          "loginType": "phone",
        });
      }
      CacheService.putData(key: CacheServiceConstants.userId, value: userCred.user!.uid);
      CacheService.putData(key: CacheServiceConstants.phoneNumber, value: userCred.user!.phoneNumber);
      CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
