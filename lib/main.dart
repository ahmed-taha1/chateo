import 'package:bloc/bloc.dart';
import 'package:chateo/chateo.dart';
import 'package:chateo/core/di/get_it.dart';
import 'package:chateo/core/services/cache_service.dart';
import 'package:chateo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';
import 'core/services/bloc_observer.dart';

Future<void> foregroundNotificationHandler(RemoteMessage message) async {
  print('Handling a foreground message ${message.messageId}');
}

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await CacheService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if(!FirebaseMessaging.instance.isAutoInitEnabled){
    await FirebaseMessaging.instance.requestPermission();
  }
  FirebaseMessaging.onMessage.listen(foregroundNotificationHandler);
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  await AppRouter.setInitialRoute();
  setupGetIt();
  runApp(const Chateo());
}