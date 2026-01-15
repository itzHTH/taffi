import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/core/theme/app_colors.dart';

import 'package:taffi/features/chat/widgets/custom_app_bar.dart';
import 'package:taffi/features/chat/widgets/custom_chat_field_bottom.dart';
import 'package:taffi/features/chat/widgets/date_header_delegate.dart';
import 'package:taffi/features/chat/widgets/sliver_messages_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPersistentHeader(
            pinned: true,
            delegate: DateHeaderDelegate("2026/1/19"),
          ),
          SliverMessagesList(),
        ],
      ),
      bottomSheet: CustomChatFieldBottom(),
    );
  }
}
