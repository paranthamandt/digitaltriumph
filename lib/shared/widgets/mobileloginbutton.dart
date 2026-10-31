
import 'package:flutter/material.dart';

class MobileLoginButton extends StatelessWidget {
final VoidCallback onPressed;

const MobileLoginButton({
super.key,
required this.onPressed,
});

@override
 Widget build(BuildContext context) {
 return OutlinedButton.icon(
 onPressed: onPressed,
 icon: const Icon(Icons.phone_iphone),
 label: const Text('Mobile Login'),
 style: OutlinedButton.styleFrom(
 backgroundColor: Colors.white,
 foregroundColor: const Color(0xFF009F89),
 side: const BorderSide(
 color: Color(0xFF00BFA5),
 width: 1.5,
),
 minimumSize: const Size(double.infinity, 50),
 shape: RoundedRectangleBorder(
 borderRadius: BorderRadius.circular(12),
 ),
 textStyle: const TextStyle(
 fontSize: 16,
 fontWeight: FontWeight.bold,
 ),
 ),
 );
  }
 }
