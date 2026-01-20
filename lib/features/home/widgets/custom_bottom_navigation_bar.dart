import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  final List<Map<String, dynamic>> _items = [
    {"icon": "assets/images/home.svg", "label": "الرئيسية"},
    {
      "icon": "assets/images/messages.svg",
      "label": "الرسائل",
    },
    {
      "icon": "assets/images/calendar.svg",
      "label": "جدول المواعيد",
    },
    {
      "icon": "assets/images/profile.svg",
      "label": "الملف الشخصي",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.map((item) {
            final index = _items.indexOf(item);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => widget.onTap(index),
              child: CustomBottomNavItem(
                itemLabel: item["label"],
                itemIconPath: item["icon"],
                isActive: widget.currentIndex == index,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomBottomNavItem extends StatelessWidget {
  final String itemIconPath;
  final String itemLabel;
  final bool isActive;

  const CustomBottomNavItem({
    super.key,
    required this.itemIconPath,
    required this.itemLabel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isActive ? 1.0 : 0.0,
              child: AnimatedScale(
                scale: isActive ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SvgPicture.asset(
                  "assets/images/bg_active.svg",
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(
                bottom: isActive ? 10.0 : 0,
              ),
              child: SvgPicture.asset(
                itemIconPath,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  isActive ? Colors.white : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isActive ? 0 : 8),
        Text(
          itemLabel,
          style: Theme.of(context).textTheme.bodyMedium!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
