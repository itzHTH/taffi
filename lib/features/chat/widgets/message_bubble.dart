import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isUserSender,
  });

  final String message;
  final bool isUserSender;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: isUserSender ? Color(0xffD9D9D9) : Color(0xff5A768A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(isUserSender ? 0 : 24),
            bottomLeft: Radius.circular(isUserSender ? 24 : 0),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Column(
          crossAxisAlignment: isUserSender
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: isUserSender ? Colors.black : Colors.white,
              ),
            ),
            Text(
              "12:00 P.M.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isUserSender
                    ? Colors.black.withAlpha(128)
                    : Colors.white.withAlpha(128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
