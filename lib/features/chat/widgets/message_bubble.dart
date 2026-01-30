import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/utils/helpers.dart';
import 'package:taffi/features/chat/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUserMessage ?? false ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: message.isUserMessage ?? false ? AppColors.secondary : Color(0xffD9D9D9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(message.isUserMessage ?? false ? 0 : 24),
            bottomLeft: Radius.circular(message.isUserMessage ?? false ? 24 : 0),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: Colors.white.withValues(alpha: 0.2),
            highlightColor: Colors.white.withValues(alpha: 0.1),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: message.isUserMessage ?? false
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: message.isUserMessage ?? false ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    formatTimestamp(message.timestamp ?? ""),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: message.isUserMessage ?? false
                          ? Colors.white.withAlpha(128)
                          : Colors.black.withAlpha(128),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
