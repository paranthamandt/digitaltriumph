
import 'package:flutter/material.dart';

class BlueBackground extends StatelessWidget {
  final Widget child;

  const BlueBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF20BE96),
      child: Stack(
        children: [
          // Dark blue circle at the top
          Positioned(
            top: -100,
            left: 100,
            child: Container(
              width: 350,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFF079879),
                borderRadius: BorderRadius.circular(180),
              ),
            ),
          ),

          // Decorative circle
          Positioned(
            top: 100,
            right: 25,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF65E8C3),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          // Positioned(
          //   top: 270,
          //   right: 100,
          //   child: Container(
          //     width: 45,
          //     height: 45,
          //     decoration: const BoxDecoration(
          //       color: Color(0xFF079879),
          //       shape: BoxShape.circle,
          //     ),
          //   ),
          // ),

          // Screen content
          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
