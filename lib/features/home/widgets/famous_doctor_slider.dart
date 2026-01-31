import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taffi/core/enums/status_enum.dart';
import 'package:taffi/core/routing/route_names.dart';
import 'package:taffi/core/theme/app_colors.dart';
import 'package:taffi/core/widgets/big_doctor_card.dart';
import 'package:taffi/core/widgets/error_retry_widget.dart';
import 'package:taffi/features/Doctor_Info/models/doctor_model.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/home/widgets/doctor_slider_shimmer.dart';

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
      if (_currentPage < context.read<DoctorProvider>().topDoctors.length - 1) {
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

  void setDoctor(DoctorModel doctor) {
    final provider = context.read<DoctorProvider>();
    provider.setDoctor(doctor);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DoctorProvider>();

    // Show shimmer only during loading
    if (provider.topDoctorsStatus == Status.loading) {
      _stopTimer();
      return const DoctorSliderShimmer();
    }

    // Show error state with retry (BEFORE checking if empty!)
    if (provider.topDoctorsStatus == Status.error) {
      _stopTimer();
      return ErrorRetryWidget(
        errorMessage: provider.errorMessage ?? "حدث خطأ أثناء تحميل الأطباء المميزين",
        onRetry: () => provider.getTopDoctors(),
        iconSize: 48,
      );
    }

    // Show shimmer if list is empty (after success)
    if (provider.topDoctors.isEmpty) {
      _stopTimer();
      return const DoctorSliderShimmer();
    }

    // Success - show slider
    _startTimer();
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
              itemCount: provider.topDoctors.length,
              itemBuilder: (context, index) {
                final doctor = provider.topDoctors[index];
                return BigDoctorCard(
                  doctorName: doctor.name ?? "اسم الطبيب",
                  doctorSpecialization: doctor.specialtyName ?? "التخصص",
                  rating: doctor.rate ?? 0,
                  doctorImage: doctor.imageUrl ?? "",
                  doctorLocation: doctor.location ?? "الموقع",
                  onBookingTap: () async {
                    Navigator.pushNamed(context, RouteNames.doctorInfo, arguments: doctor);
                  },
                );
              },
              physics: const BouncingScrollPhysics(),
            ),
          ),
          const SizedBox(height: 12),
          SmoothPageIndicator(
            controller: _pageController,
            count: provider.topDoctors.length,
            effect: const ExpandingDotsEffect(
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
