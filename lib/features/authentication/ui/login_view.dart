import 'package:chateo/core/routing/routes.dart';
import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/custom_button.dart';
import 'package:chateo/core/widgets/custom_input_text_field.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:chateo/features/authentication/logic/authentication_cubit.dart';
import 'package:chateo/features/authentication/ui/widgets/login_bloc_listener.dart';
import 'package:chateo/features/authentication/ui/widgets/social_media_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(150.h),
              Text(
                textAlign: TextAlign.center,
                "Let's Get Started",
                style: TextStyles.font20BlackPurpleSemiBold.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 28.sp,
                ),
              ),
              verticalSpace(40),
              CustomInputTextField(
                hintText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email_outlined,
              ),
              verticalSpace(20),
              CustomInputTextField(
                hintText: "Password",
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              verticalSpace(20),
              CustomButton(
                text: "Login",
                onPressed: () {
                  context.read<AuthenticationCubit>().loginViaEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
              ),
              verticalSpace(40),
              const SocialMediaLogin(),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyles.font15BlackPurpleMedium.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  horizontalSpace(10),
                  GestureDetector(
                    onTap: () {
                      context.push(Routes.registerView.path);
                    },
                    child: Text(
                      "Register",
                      style: TextStyles.font15BlackPurpleMedium.copyWith(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ],
              ),
              const LoginBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}

/*
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),

 */
