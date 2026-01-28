import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.35;

    return SliverAppBar(
      expandedHeight: expandedHeight,
      collapsedHeight: 60,
      pinned: true,
      floating: true,
      snap: true,
      stretch: true,
      backgroundColor: AppColors.secondary,
      title: const Text(
        'معلومات الدكتور',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      ),

      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
      centerTitle: true,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          final expandedHeight = screenHeight * 0.35;
          final collapsedHeight = 60.0;
          final currentHeight = constraints.maxHeight;

          final percent = ((currentHeight - collapsedHeight) / (expandedHeight - collapsedHeight))
              .clamp(0.0, 1.0);

          final scale = 0.6 + (percent * 0.4);
          return FlexibleSpaceBar(
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: expandedHeight * 0.15),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: 0.5 * percent,
                      child: SizedBox(
                        height: expandedHeight * 0.3,
                        child: Image.asset('assets/images/wave.png'),
                      ),
                    ),
                    Transform.scale(
                      scale: scale,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: screenWidth * 0.6,
                            height: expandedHeight * 0.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          final screenWidth = MediaQuery.of(context).size.width;
                          final screenHeight = MediaQuery.of(context).size.height;
                          final expandedHeight = screenHeight * 0.35;

                          return SizedBox(
                            width: screenWidth * 0.5,
                            height: expandedHeight * 0.7,
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: screenWidth * 0.2,
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          final screenWidth = MediaQuery.of(context).size.width;
                          final screenHeight = MediaQuery.of(context).size.height;
                          final expandedHeight = screenHeight * 0.35;

                          return Container(
                            width: screenWidth * 0.5,
                            height: expandedHeight * 0.7,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.white, size: 40),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
