import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TypingIndicatorBubble extends StatelessWidget {
  const TypingIndicatorBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        constraints: const BoxConstraints(maxWidth: 80),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffD9D9D9), width: 1.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animations/typing.json',
            width: 60,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
