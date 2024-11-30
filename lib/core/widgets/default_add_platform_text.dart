import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'spacing.dart';
import '../theming/text_styles.dart';

class DefaultAddPlatformText extends StatelessWidget {
  const DefaultAddPlatformText(
      {super.key,
      required this.mainText,
      required this.subText,
      this.isLogoIncluded,
      this.iconPath});

  final String mainText;
  final String subText;
  final bool? isLogoIncluded;
  final String? iconPath;

  @override
  Widget build(BuildContext context) {
    Widget firstWidget;
    if (isLogoIncluded != null && isLogoIncluded == true) {
      firstWidget = SvgPicture.asset("assets/svgs/platforms.svg",
          height: 174.h, width: 174.w);
    } else if (iconPath != null) {
      firstWidget = SvgPicture.asset(iconPath!, height: 204.h, width: 204.w);
    } else {
      firstWidget = const Padding(padding: EdgeInsets.all(0));
    }

    return Column(
      children: [
        firstWidget,
        verticalSpace(53.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyles.font30BlackPurpleBold,
              ),
              verticalSpace(11.h),
              Text(
                subText,
                style: TextStyles.font15DarkGreySemiBold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
