import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/custom_input_text_field.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:chateo/features/communities/ui/widgets/commuinity_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            CommuinityTile(
              imagePath: "assets/svgs/islam.jpg",
              title: "Islam",
              isSubscribed: false,
              onPressed: (){},
            ),
            verticalSpace(30.h),
            CommuinityTile(
              imagePath: "assets/svgs/codeforces.jpg",
              title: "Codeforces",
              isSubscribed: false,
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
