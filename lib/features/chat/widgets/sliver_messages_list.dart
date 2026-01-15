import 'package:flutter/material.dart';
import 'package:taffi/features/chat/widgets/message_bubble.dart';

class SliverMessagesList extends StatefulWidget {
  const SliverMessagesList({super.key});

  @override
  State<SliverMessagesList> createState() => _SliverMessagesListState();
}

class _SliverMessagesListState extends State<SliverMessagesList> {
  final List<Map<String, dynamic>> messages = [
    {"message": "Hello", "isUserSender": true},
    {"message": "Hello Sir", "isUserSender": false},
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: MessageBubble(
            message: messages[index]["message"],
            isUserSender: messages[index]["isUserSender"],
          ),
        );
      },
    );
  }
}
