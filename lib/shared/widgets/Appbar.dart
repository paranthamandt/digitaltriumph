import 'package:flutter/material.dart';
class Appbar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  
  const Appbar({super.key,
  required this.title,
    required this.actions
  });

  @override
  Widget build(BuildContext context) {
    return Appbar(title: title,
        actions: actions
    );
  }
}
