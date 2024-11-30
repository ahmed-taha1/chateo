// import 'package:chateo/core/services/cache_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _firebaseAuth;
//   final FirebaseFirestore _fireStore;

//   const AuthService(this._firebaseAuth, this._fireStore);

//   Future<void> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       CacheService.putData(key: CacheServiceConstants.token, value: userCredential.credential!.token);
//       CacheService.putData(key: CacheServiceConstants.isLogged, value: true);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> signInWithToken(String token) async {
//     try {
//       await _firebaseAuth.signInWithCustomToken(token);
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> createUserWithEmailAndPassword({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       await _fireStore.collection("users").doc(credential.user!.uid).set({
//         "name": name,
//         "email": email,
//         "uid": credential.user!.uid,
//       });
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }


// }
