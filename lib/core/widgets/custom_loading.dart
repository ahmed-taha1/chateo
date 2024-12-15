import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void showCustomLoading(){
  EasyLoading.show(
    dismissOnTap: false,
    maskType: EasyLoadingMaskType.black,
    indicator: const CircularProgressIndicator(
      strokeCap: StrokeCap.round,
      strokeWidth: 0.7,
      color: Colors.white,
    ),
  );
}
