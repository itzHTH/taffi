import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/core/widgets/error_banner.dart';
import 'package:taffi/features/chat/models/message_model.dart';
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

        // Show error state with retry button
        if (chatProvider.getChatStatus == Status.error) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: ErrorRetryWidget(
              errorMessage: chatProvider.errorMessage ?? "حدث خطأ أثناء تحميل الرسائل",
              onRetry: () => chatProvider.getChatMessages(),
            ),
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

        // Calculate item count: messages + typing indicator if loading + error banner if error
        final isTyping = chatProvider.sendMessageStatus == Status.loading;
        final hasError = chatProvider.sendMessageStatus == Status.error;
        var itemCount = reversedMessages.length;
        if (isTyping) itemCount++;
        if (hasError) itemCount++;

        return SliverList.builder(
          itemCount: itemCount,
          itemBuilder: (context, index) {
            var currentIndex = index;

            // Show error banner as first item if there's an error
            if (hasError && currentIndex == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ErrorBanner(
                  errorMessage: chatProvider.errorMessage ?? "فشل إرسال الرسالة",
                  onRetry: () {
                    // Get the last user message and resend it
                    final lastUserMessage = reversedMessages.firstWhere(
                      (msg) => msg.isUserMessage ?? false,
                      orElse: () => MessageModel(),
                    );
                    if (lastUserMessage.content != null) {
                      chatProvider.sendMessage(lastUserMessage.content!);
                    }
                  },
                ),
              );
            }

            // Adjust index if error banner is shown
            if (hasError) currentIndex--;

            // Show typing indicator as first item (after error banner if present)
            if (isTyping && currentIndex == 0) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TypingIndicatorBubble(),
              );
            }

            // Adjust index for messages when typing indicator is present
            final messageIndex = isTyping ? currentIndex - 1 : currentIndex;

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
