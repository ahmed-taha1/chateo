import 'dart:ffi';

import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CommuinityTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final bool isSubscribed;
  final VoidCallback onPressed;
  const CommuinityTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.isSubscribed, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                foregroundImage: AssetImage(imagePath),
                radius: 23,
              ),
              horizontalSpace(5),
              Text(
                title,
                style: TextStyles.font15BlackPurpleSemiBold.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Text(
            isSubscribed ? "" : "Press to subscribe and join",
            style: TextStyles.font15BlackPurpleMedium.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
