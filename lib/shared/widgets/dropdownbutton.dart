import 'package:flutter/material.dart';
class Dropdownbutton extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? value;
  // final ValueChanged<String?> onChanged;
  final ValueChanged<String?>? onChanged;

  const Dropdownbutton({super.key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,


  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFE8F8F3),
      hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFB7DCD0),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFF16B995),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
      // border: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(12),




          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12)
          )
      ),



      items: items.map((item) {
      return DropdownMenuItem<String>(
      value: item,
      child: Text(item),
      );
      }).toList(),
      onChanged: onChanged,
      ),
    );
  }


  }

