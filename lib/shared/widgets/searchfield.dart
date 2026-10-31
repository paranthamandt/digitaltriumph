import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final int filterCount;
  const SearchField({Key? key,this.onChanged,this.filterCount=0,this.onFilterTap}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            hintStyle: const TextStyle(color: Color(0xFF757575)),
            fillColor: const Color(0xFF979797).withOpacity(0.1),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none,
            ),
            hintText: "Search product",
            prefixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}

// import 'package:firstapipro/core/theme/appcolor.dart';
// import 'package:flutter/material.dart';
//
// class SearchField extends StatelessWidget {
//   final ValueChanged<String>? onChanged;
//   final VoidCallback? onFilterTap;
//   final int filterCount;
//
//   const SearchField({
//     Key? key,
//     this.onChanged,
//     this.onFilterTap,
//     this.filterCount = 0,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     const navy = Color(0xFF1A0F8C);
//
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: TextFormField(
//         onChanged: onChanged,
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: Colors.white,
//           hintText: "Search by model, code, or serial no...",
//           hintStyle: const TextStyle(color: Color(0xFF757575), fontSize: 13),
//           contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           prefixIcon: const Icon(Icons.search, color: navy),
//           suffixIcon: onFilterTap == null
//               ? null
//               : IconButton(
//             onPressed: onFilterTap,
//             icon: Badge(
//               isLabelVisible: filterCount > 0,
//               label: Text('$filterCount'),
//               backgroundColor: Appcolor.backgroundColor,
//               child: const Icon(Icons.tune, color: navy),
//             ),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: BorderSide(color: Colors.grey.shade200),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: BorderSide(color: Colors.grey.shade200),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(14),
//             borderSide: const BorderSide(color: navy),
//           ),
//         ),
//       ),
//     );
//   }
// }
