import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/app_colors.dart';
import '../theming/text_styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
  });

  final bool isLoading;
  final String text;
  final VoidCallback onPressed;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 300.w,
      child: ElevatedButton(
        onPressed: isLoading ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor?? Theme.of(context).primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(AppColors.white),
                  strokeWidth: 2.w,
                )
              : Text(
                  text,
                  style: TextStyles.font17WhiteBold,
                ),
        ),
      ),
    );
  }
}
