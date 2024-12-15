import 'package:chateo/core/widgets/snack_bar.dart';
import 'package:chateo/features/authentication/logic/authentication_cubit.dart';
import 'package:chateo/features/authentication/ui/widgets/register_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/text_styles.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_input_text_field.dart';
import '../../../core/widgets/spacing.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmationController =
        TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 80.h,
              bottom: 20.h,
              left: 40.w,
              right: 40.w,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Create An\nAccount",
                      style: TextStyles.font15BlackPurpleSemiBold.copyWith(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 40.sp),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                verticalSpace(40),
                CustomInputTextField(
                  hintText: "Full Name",
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.person_outline_rounded,
                ),
                verticalSpace(20),
                CustomInputTextField(
                  hintText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                ),
                verticalSpace(20),
                CustomInputTextField(
                  hintText: "Phone Number",
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone_outlined,
                ),
                verticalSpace(20),
                CustomInputTextField(
                  hintText: "Password",
                  controller: passwordController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  keyboardType: TextInputType.text,
                ),
                verticalSpace(20),
                CustomInputTextField(
                  hintText: "Password Confirmation",
                  controller: passwordConfirmationController,
                  icon: Icons.lock_outline,
                  isPassword: true,
                  keyboardType: TextInputType.text,
                ),
                verticalSpace(20),
                CustomButton(
                  text: "Register",
                  onPressed: () {
                    if (passwordController.text !=
                        passwordConfirmationController.text) {
                      showSnackBar(
                          context: context,
                          message: "please make sure your password match");
                    } else {
                      context
                          .read<AuthenticationCubit>()
                          .registerViaEmailAndPassword(
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            password: passwordController.text,
                          );
                    }
                  },
                ),
                verticalSpace(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have an account?",
                      style: TextStyles.font15BlackPurpleMedium.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    horizontalSpace(10),
                    GestureDetector(
                      onTap: () {
                        context.pushReplacement(Routes.loginView.path);
                      },
                      child: Text(
                        "Login",
                        style: TextStyles.font15BlackPurpleMedium.copyWith(
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                  ],
                ),
                const RegisterBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
