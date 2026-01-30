import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/features/chat/providers/chat_provider.dart';
import 'package:taffi/features/messages/widgets/sliver_doctor_messages_list.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.background,
              title: Text("المحادثات", style: Theme.of(context).textTheme.titleLarge),
              automaticallyImplyLeading: false,
              centerTitle: true,
              floating: false,
              snap: false,
              pinned: true,
              scrolledUnderElevation: 0,
            ),
            SliverDoctorMessagesList(),
          ],
        ),
      ),
    );
  }
}
