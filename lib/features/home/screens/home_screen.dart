import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:taffi/core/widgets/custom_refresh_indicator.dart';
import 'package:taffi/features/Doctor_Info/providers/doctor_provider.dart';
import 'package:taffi/features/auth/providers/user_provider.dart';
import 'package:taffi/features/home/widgets/famous_doctor_slider.dart';
import 'package:taffi/features/home/widgets/custom_sliver_app_bar.dart';
import 'package:taffi/features/home/widgets/custom_specialties_section.dart';
import 'package:taffi/features/home/widgets/cutom_search_bar.dart';
import 'package:taffi/features/home/widgets/sliver_special_doctors_gird.dart';
import 'package:taffi/features/specialties/providers/specialty_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getTopDoctors();
    });
  }

  Future<void> getTopDoctors() async {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    await doctorProvider.getTopDoctors();
  }

  Future<void> _onRefresh() async {
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final specialtyProvider = Provider.of<SpecialtyProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await Future.wait([
      doctorProvider.getAllDoctors(),
      doctorProvider.getTopDoctors(),
      specialtyProvider.getSpecialties(),
      userProvider.getUserInfo(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomRefreshIndicator(
        onRefresh: _onRefresh,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 16)),
                  CustomSliverAppBar(),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(child: Center(child: CutomSearchBar())),
                  SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(child: FamousDoctorSlider()),
                  SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(child: CustomSpecialtiesSection()),
                  SliverToBoxAdapter(child: SizedBox(height: 32)),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/popular.svg", width: 28),
                            SizedBox(width: 8),
                            Text("الأكثر شهرة", style: Theme.of(context).textTheme.labelSmall),
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
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
