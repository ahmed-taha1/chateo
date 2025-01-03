import 'package:chateo/core/services/analytics_service.dart';
import 'package:chateo/features/authentication/data/auth_repo.dart';
import 'package:chateo/features/chat/data/chat_repo.dart';
import 'package:chateo/features/communities/data/communities_repo.dart';
import 'package:chateo/features/home/data/home_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(fireStore));
  getIt.registerLazySingleton<CommunitiesRepo>(() => CommunitiesRepo(firebaseMessaging, fireStore, getIt<AnalyticsService>()));
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo(firebaseDatabase));
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepo(firebaseAuth, fireStore, getIt<AnalyticsService>()));
  getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}