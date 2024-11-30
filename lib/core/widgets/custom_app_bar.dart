import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.isScrolled = false,
    this.onPressed, required this.backGroundColor,
  });

  final VoidCallback? onPressed;
  final Color backGroundColor;
  // final Brightness brightness;
  // final Color statusBarColor;
  final bool isScrolled;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black26,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: backGroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
