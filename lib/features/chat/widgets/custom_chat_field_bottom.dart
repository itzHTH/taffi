import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taffi/core/theme/app_colors.dart';

class CustomChatFieldBottom extends StatelessWidget {
  const CustomChatFieldBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5), // ظل خفيف للأعلى لتمييز الحقل
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 6,

            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? 6
                : MediaQuery.of(context).padding.bottom,
          ),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/images/send.svg",
                  width: 36,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    maxLines: 5,
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: "اكتب رسالتك هنا...",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.2),
                        borderRadius: BorderRadius.circular(25),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.6),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
