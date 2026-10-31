import 'package:flutter/material.dart';

class Appbutton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;

  const Appbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    );

    final child = isLoading
        ? const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(strokeWidth: 2),
    )
        : Text(text);


    final VoidCallback? action = isLoading ? null : onPressed;

    return SizedBox(
      height: 50,
      child: isOutlined
          ? OutlinedButton(
        onPressed: action,
        style: OutlinedButton.styleFrom(shape: shape),
        child: child,
      )
          : ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          shape: shape,
          backgroundColor: const Color(0xFF16B995),
          foregroundColor: Colors.white,
        ),
        child: child,
      ),
    );
  }
}