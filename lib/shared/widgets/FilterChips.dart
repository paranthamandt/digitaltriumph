import 'package:flutter/material.dart';

import '../../core/theme/appcolor.dart';
import '../../core/theme/textstyle.dart';

class FilterChips extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onSelected;
  final String allLabel;

  const FilterChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.allLabel = 'All',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          _chip(allLabel, selected == null, () => onSelected(null)),
          ...options.map(
                (o) => _chip(o, selected == o, () => onSelected(o)),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label,style: Textstyle.body1,),selectedColor: Appcolor.backgroundColor,
        selected: isSelected,
        showCheckmark: false,
        side: BorderSide(
          color: isSelected ? Colors.transparent : Colors.grey.shade400,
        ),
        onSelected: (_) => onTap(),
      ),
    );
  }
}