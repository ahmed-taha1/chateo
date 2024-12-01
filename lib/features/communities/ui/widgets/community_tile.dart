import 'package:chateo/core/theming/text_styles.dart';
import 'package:chateo/core/widgets/spacing.dart';
import 'package:flutter/material.dart';

class CommunityTile extends StatefulWidget {
  final String imagePath;
  final String title;
  bool isSubscribed;
  final VoidCallback onPressed;
  final VoidCallback onSubscribe;
  final VoidCallback onUnsubscribe;

  CommunityTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.isSubscribed,
    required this.onPressed,
    required this.onSubscribe,
    required this.onUnsubscribe,
  });

  @override
  State<CommunityTile> createState() => _CommunityTileState();
}

class _CommunityTileState extends State<CommunityTile> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                foregroundImage: AssetImage(widget.imagePath),
                radius: 23,
              ),
              horizontalSpace(5),
              Text(
                widget.title,
                style: TextStyles.font15BlackPurpleSemiBold.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (widget.isSubscribed) {
                setState(() {
                  widget.isSubscribed = false;
                });
                widget.onUnsubscribe();
              } else {
                setState(() {
                  widget.isSubscribed = true;
                });
                widget.onSubscribe();
              }
            },
            icon: Icon(
              widget.isSubscribed ? Icons.check : Icons.add,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
