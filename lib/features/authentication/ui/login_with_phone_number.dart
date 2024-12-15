import 'package:chateo/features/authentication/ui/widgets/login_with_phone_number_bloc_listener.dart';
import 'package:chateo/features/authentication/ui/widgets/phone_number_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/authentication_cubit.dart';

class LoginWithPhoneNumber extends StatelessWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PhoneNumberForm(
            header: "Please Add your Phone Number To Login",
            onProceed: (String phoneNumber) {
              context
                  .read<AuthenticationCubit>()
                  .sendOtp(phoneNumber);
            },
          ),
          const LoginWithPhoneNumberBlocListener(),
        ],
      ),
    );
  }
}
