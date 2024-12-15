import 'package:chateo/features/authentication/logic/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/snack_bar.dart';

class RegisterBlocListener extends StatelessWidget {
  const RegisterBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          showCustomLoading();
        } else if (state is AuthenticationRegisterSuccess) {
          EasyLoading.dismiss();
          showSnackBar(context: context, message: "Registration successful", color: Colors.green);
          context.go(Routes.loginView.path);
        } else if (state is AuthenticationFailed) {
          EasyLoading.dismiss();
          showSnackBar(context: context, message: state.message);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
