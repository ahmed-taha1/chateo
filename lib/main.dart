import 'package:chateo/chateo.dart';
import 'package:chateo/core/di/get_id.dart';
import 'package:chateo/core/services/cache_service.dart';
import 'package:chateo/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await CacheService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // setupGetIt();
  runApp(const Chateo());
}