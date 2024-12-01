import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/custom_input_text_field.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:chateo/features/communities/logic/communities_cubit.dart';
import 'package:chateo/features/communities/ui/widgets/communities_bloc_listener.dart';
import 'package:chateo/features/communities/ui/widgets/community_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routing/routes.dart';

class CommunitiesView extends StatelessWidget {
  const CommunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Communities",
              style: TextStyles.font11WhiteSemiBold.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 20.sp,
              ),
            ),
            verticalSpace(25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomInputTextField(
                hintText: "search",
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                icon: Icons.search,
              ),
            ),
            verticalSpace(30.h),
            Expanded(
              child: ListView.builder(
                itemCount: context.read<CommunitiesCubit>().communities.length,
                itemBuilder: (context, index) {
                  final community =
                      context.read<CommunitiesCubit>().communities[index];
                  return Column(
                    children: [
                      CommunityTile(
                        imagePath: community.image,
                        title: community.name,
                        isSubscribed: community.isSubscribed,
                        onPressed: () {
                          context.push(
                            Routes.chatView.path,
                            extra: {
                              "phoneNumber": context.read<CommunitiesCubit>().phoneNumber,
                              "chatId": community.name,
                            },
                          );
                        },
                        onSubscribe: () =>
                            context.read<CommunitiesCubit>().subscribe(index),
                        onUnsubscribe: () =>
                            context.read<CommunitiesCubit>().unsubscribe(index),
                      ),
                      verticalSpace(30.h),
                    ],
                  );
                },
              ),
            ),
            const CommunitiesBlocListener(),
          ],
        ),
      ),
    );
  }
}
