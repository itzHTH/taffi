import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/custom_refresh_indicator.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/chat/providers/chat_provider.dart';
import 'package:taffi/features/messages/widgets/sliver_doctor_messages_list.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    await doctorProvider.getAllDoctors();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: Scaffold(
        body: CustomRefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
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
      ),
    );
  }
}
