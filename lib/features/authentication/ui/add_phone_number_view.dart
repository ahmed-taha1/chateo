import 'package:chateo/features/authentication/logic/authentication_cubit.dart';
import 'package:chateo/features/authentication/ui/widgets/add_phone_number_bloc_listener.dart';
import 'package:chateo/features/authentication/ui/widgets/phone_number_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPhoneNumberView extends StatelessWidget {
  const AddPhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PhoneNumberForm(
            header: "Please add your phone number to create your account",
            onProceed: (String phoneNumber) {
              context
                  .read<AuthenticationCubit>()
                  .addPhoneNumberToGoogleAccount(phoneNumber);
            },
          ),
          const AddPhoneNumberBlocListener(),
        ],
      ),
    );
  }
}