
import 'package:flutter/material.dart';

import '../../core/theme/textstyle.dart';

class Cardprouct extends StatelessWidget {
  final String image;
  final String name;
  final String code;
  final VoidCallback? onTap;
  final String? description;

  const Cardprouct({
    super.key,
    required this.image,
    required this.name,
    required this.code,
    this.onTap,
    this.description
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(child: _buildImage()),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                name,
                style: Textstyle.cardTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
              child: Text(
                code,
                style: Textstyle.cardTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
              child: Text(
                description??"",
                style: Textstyle.cardTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    const placeholder = Expanded(child: Center(child: Icon(Icons.image_not_supported, size: 48)));

    if (image.isEmpty) return placeholder;

    if (image.startsWith('http')) {
      return Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) => placeholder,
      );
    }

    return Image.asset(
      image,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}
