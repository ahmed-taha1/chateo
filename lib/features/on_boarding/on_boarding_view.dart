import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/custom_button.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/routes.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 150.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svgs/on_boarding.svg",
                width: 200,
              ),
              verticalSpace(40),
              Text(
                textAlign: TextAlign.center,
                "Connect easily with\nyour friends and family\nover the world",
                style: TextStyles.font20BlackPurpleSemiBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25.sp,
                ),
              ),
              verticalSpace(180),
              CustomButton(
                text: "Start Messaging",
                onPressed: () => context.go(Routes.loginView.path),
              ),
            ],
          ),
        ),
      ),
    );
  }
}