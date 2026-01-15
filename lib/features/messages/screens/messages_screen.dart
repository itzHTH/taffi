import 'package:flutter/material.dart';
import 'package:taffi/features/messages/widgets/sliver_doctor_messages_list.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "الرسائل",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          SliverDoctorMessagesList(),
        ],
      ),
    );
  }
}
