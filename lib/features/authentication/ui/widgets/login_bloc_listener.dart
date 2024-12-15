import 'package:chateo/core/widgets/snack_bar.dart';
import 'package:chateo/features/authentication/logic/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_loading.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          showCustomLoading();
        } else {
          EasyLoading.dismiss();
          if (state is AuthenticationLoginSuccess) {
            context.go(Routes.homeView.path);
          } else if (state is AuthenticationFailed) {
            showSnackBar(
                context: context, message: state.message, color: Colors.red);
          }
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
