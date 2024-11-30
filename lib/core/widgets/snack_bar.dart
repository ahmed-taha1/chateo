import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message, Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color ?? Colors.redAccent,
      content: Text(message, style: const TextStyle(color: Colors.white)),
      duration: const Duration(seconds: 2),
    ),
  );
}