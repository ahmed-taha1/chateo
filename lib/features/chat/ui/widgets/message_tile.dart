import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final bool isSentByMe;
  final String message;
  final String phoneNumber;
  const MessageTile(
      {required this.message, required this.isSentByMe, super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: isSentByMe
              ? const EdgeInsets.only(left: 30, top: 8, bottom: 8)
              : const EdgeInsets.only(right: 30, top: 8, bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isSentByMe ? Theme.of(context).primaryColorLight : Colors.white,
            borderRadius: isSentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isSentByMe
                  ? Text(
                      phoneNumber,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    )
                  : Container(),
              Text(
                message,
                style: TextStyle(
                  color: isSentByMe ? Colors.white : Colors.black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
