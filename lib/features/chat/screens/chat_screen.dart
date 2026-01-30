import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/features/chat/providers/chat_provider.dart';
import 'package:taffi/features/chat/widgets/custom_app_bar.dart';
import 'package:taffi/features/chat/widgets/custom_chat_field_bottom.dart';
import 'package:taffi/features/chat/widgets/sliver_messages_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ChatProvider>(context, listen: false).getChatMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Fixed AppBar at top
          CustomAppBar(),

          SizedBox(height: 4),
          // Messages list
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: CustomScrollView(
                reverse: true,
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 80)),
                  SliverMessagesList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: CustomChatFieldBottom(
        onSend: (message) {
          context.read<ChatProvider>().sendMessage(message);
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
