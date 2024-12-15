import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/snack_bar.dart';
import '../../logic/authentication_cubit.dart';

class LoginWithPhoneNumberBlocListener extends StatelessWidget {
  const LoginWithPhoneNumberBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationLoading) {
          showCustomLoading();
        } else {
          EasyLoading.dismiss();
          if (state is AuthenticationLoginSuccess) {
            context.go(Routes.homeView.path);
          } else if (state is AuthenticationFailed) {
            showSnackBar(
                context: context, message: state.message, color: Colors.red);
          } else if(state is AuthenticationOtpSent){
            final TextEditingController otpController = TextEditingController();
            await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Enter OTP'),
                  content: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter OTP',
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Verify'),
                      onPressed: () {
                        final otp = otpController.text;
                        if (otp.isNotEmpty) {
                          Navigator.of(context).pop();
                        } else {
                          showSnackBar(
                            context: context,
                            message: 'Please enter the OTP',
                            color: Colors.red,
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            );
            context.read<AuthenticationCubit>().verifyOtp(otpController.text);
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
