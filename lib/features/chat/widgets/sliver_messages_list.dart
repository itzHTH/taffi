import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/features/chat/providers/chat_provider.dart';
import 'package:taffi/features/chat/widgets/message_bubble.dart';
import 'package:taffi/features/chat/widgets/message_shimmer.dart';
import 'package:taffi/features/chat/widgets/typing_indicator_bubble.dart';

class SliverMessagesList extends StatelessWidget {
  const SliverMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        // Show shimmer during loading
        if (chatProvider.getChatStatus == Status.loading) {
          return SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const MessageShimmer();
            },
          );
        }

        // Show empty state if no messages
        if (chatProvider.messages.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.chat_outlined, size: 100, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    "لا توجد رسائل بعد\nابدأ المحادثة !",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          );
        }

        // Show actual messages (reversed to match reversed scroll)
        final reversedMessages = chatProvider.messages.reversed.toList();

        // Calculate item count: messages + typing indicator if loading
        final isTyping = chatProvider.sendMessageStatus == Status.loading;
        final itemCount = reversedMessages.length + (isTyping ? 1 : 0);

        return SliverList.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            // Show typing indicator as first item (bottom of screen due to reverse)
            if (isTyping && index == 0) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TypingIndicatorBubble(),
              );
            }

            // Adjust index for messages when typing indicator is present
            final messageIndex = isTyping ? index - 1 : index;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: MessageBubble(message: reversedMessages[messageIndex]),
            );
          },
        );
      },
    );
  }
}
