import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/big_doctor_card.dart';

class FamousDoctorSlider extends StatefulWidget {
  const FamousDoctorSlider({super.key});

  @override
  State<FamousDoctorSlider> createState() => _FamousDoctorSliderState();
}

class _FamousDoctorSliderState extends State<FamousDoctorSlider> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Widget _getDoctorCard(int index) {
    switch (index) {
      case 0:
        return BigDoctorCard(
          doctorName: "د. نور الهدى",
          doctorSpecialization: "طب الأسنان",
          rating: 4.40,
          doctorImage: "https://taafi.ddns.net/uploads/doctors/dr_noor.png",
          doctorLocation: "البصرة - الجزائر",
          onBookingTap: () {},
        );
      case 1:
        return BigDoctorCard(
          doctorName: "د. ليلى عبد العزيز",
          doctorSpecialization: "الجلدية والتجميل",
          rating: 4.80,
          doctorImage: "https://taafi.ddns.net/uploads/doctors/dr_layla.jpg",
          doctorLocation: "أربيل - شارع 100",
          onBookingTap: () {},
        );
      case 2:
        return BigDoctorCard(
          doctorName: "د. عمر فاروق",
          doctorSpecialization: "طب العيون",
          rating: 4.60,
          doctorImage: "https://taafi.ddns.net/uploads/doctors/dr_omar.png",
          doctorLocation: "بغداد - الحارثية",
          onBookingTap: () {},
        );
      case 3:
        return BigDoctorCard(
          doctorName: "د. أحمد عباس خالد",
          doctorSpecialization: "أمراض القلب",
          rating: 4.90,
          doctorImage: "https://taafi.ddns.net/uploads/doctors/dr_ahmed.png",
          doctorLocation: "بغداد - الكرادة",
          onBookingTap: () {},
        );

      default:
        return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        _stopTimer();
      },
      onPanEnd: (details) {
        _startTimer();
      },
      onPanCancel: () => _startTimer(),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 4,
              itemBuilder: (context, index) {
                return _getDoctorCard(index);
              },
              physics: BouncingScrollPhysics(),
            ),
          ),
          SizedBox(height: 12),
          SmoothPageIndicator(
            controller: _pageController,
            count: 4,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.secondary,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ],
      ),
    );
  }
}
