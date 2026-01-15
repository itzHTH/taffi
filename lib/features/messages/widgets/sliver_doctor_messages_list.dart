import 'package:flutter/material.dart';
import 'package:taffi/features/messages/widgets/doctor_message_card.dart';

class SliverDoctorMessagesList extends StatefulWidget {
  const SliverDoctorMessagesList({super.key});

  @override
  State<SliverDoctorMessagesList> createState() =>
      _SliverDoctorMessagesListState();
}

class _SliverDoctorMessagesListState extends State<SliverDoctorMessagesList> {
  List<Map<String, dynamic>> messages = [
    {
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_layla.png",
      "name": "دكتوره ليلى عبد العزيز",
      "message":
          "أهلاً بك! يسعدني اهتمامك بالحجز.لترتيب موعد في عيادتي، يرجى التواصل مباشرة مع سكرتارية العيادة عبر قنوات الاتصال المخصصة (الهاتف أو الموقع الإلكتروني). سيقومون بمساعدتك في اختيار الموعد المناسب وتأكيده.نتطلع لخدمتك قريباً!",
      "bio": "أخصائية الأمراض الجلدية والعلاج بالليزر، حقن الفيلر والبوتوكس.",
      "time": "20:58",
    },
    {
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_mona.png",
      "name": "د. منى سامي",
      "message": null,
      "bio": "علاج حساسية الأنف والجيوب الأنفية، عمليات تجميل الأنف.",
      "time": null,
    },
    {
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_ahmed.png",
      "name": "د. أحمد عباس خالد",
      "message": "مرحباً! كلا لا يمكنك اخذ هذا الدواء مطلقاَ؟",
      "bio":
          "أخصائي جراحة القلب والأوعية الدموية، بورد عربي، خبرة 15 سنة في القسطرة العلاجية.",
      "time": "12:30",
    },
    {
      "imageUrl": "https://taafi.ddns.net/uploads/doctors/dr_omar.png",
      "name": "د. عمر فاروق",
      "message": null,
      "bio": "استشاري طب وجراحة العيون، تصحيح البصر بالليزك.",
      "time": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: DoctorMessageCard(
            imageUrl: messages[index]["imageUrl"],
            name: messages[index]["name"],
            message: messages[index]["message"] ?? messages[index]["bio"],
            time: messages[index]["time"] ?? "",
          ),
        );
      },
    );
  }
}
