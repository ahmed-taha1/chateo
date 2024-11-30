import 'package:chateo/core/routing/routes.dart';
import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/custom_button.dart';
import 'package:chateo/core/widgets/custom_input_text_field.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(150.h),
              Text(
                textAlign: TextAlign.center,
                "Enter Your Phone Number",
                style: TextStyles.font20BlackPurpleSemiBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 28.sp,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                "Let's Start Chatting with your friends and family",
                style: TextStyles.font15BlackPurpleMedium.copyWith(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
              verticalSpace(40.h),
              Row(
                children: [
                  Text(
                    "+02 ",
                    style: TextStyles.font20BlackPurpleSemiBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.sp,
                    ),
                  ),
                  Expanded(
                    child: CustomInputTextField(
                      hintText: "Phone Number",
                      controller: TextEditingController(),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              verticalSpace(40.h),
              CustomButton(
                  text: "Continute",
                  onPressed: () => context.go(Routes.homeView.path)),
            ],
          ),
        ),
      ),
    );
  }
}
