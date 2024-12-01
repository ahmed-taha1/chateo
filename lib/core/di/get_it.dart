import 'package:chateo/features/chat/data/chat_repo.dart';
import 'package:chateo/features/communities/data/communities_repo.dart';
import 'package:chateo/features/home/data/home_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(fireStore));
  getIt.registerLazySingleton<CommunitiesRepo>(() => CommunitiesRepo(firebaseMessaging, fireStore));
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepo(firebaseDatabase));
}