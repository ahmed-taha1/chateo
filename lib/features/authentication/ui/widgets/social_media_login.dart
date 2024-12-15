import 'package:chateo/core/routing/routes.dart';
import 'package:chateo/features/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theming/text_styles.dart';
import '../../../../core/widgets/spacing.dart';
import '../../logic/authentication_cubit.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: Theme.of(context).hintColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "OR Login Via",
                style: TextStyles.font15BlackPurpleMedium.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
        verticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: SvgPicture.asset("assets/svgs/google_icon.svg"),
              onTap: () {
                context.read<AuthenticationCubit>().loginWithGoogle();
              },
            ),
            horizontalSpace(20),
            GestureDetector(
              onTap: () {
                context.push(Routes.loginWithPhoneNumber.path);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xECD5D3D3),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(9),
                child: Icon(
                  Icons.phone_rounded,
                  size: 28,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
