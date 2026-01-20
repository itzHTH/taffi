import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taffi/features/home/widgets/Famous_doctor_slider.dart';
import 'package:taffi/features/home/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/home/widgets/custom_specialties_section.dart';
import 'package:taffi/features/home/widgets/cutom_search_bar.dart';
import 'package:taffi/features/home/widgets/sliver_special_doctors_gird.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              SliverToBoxAdapter(
                child: Center(child: CutomSearchBar()),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: FamousDoctorSlider(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: CustomSpecialtiesSection(),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 32),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/popular.svg",
                          width: 28,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "الأكثر شهرة",
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
              SliverSpecialDoctorsGird(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
