import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

import '../../core/theme/textstyle.dart';
import '../../data/models/productCategory.dart';

class HomeProductCard extends StatelessWidget {
  final Productcategory product;
  final VoidCallback onTap;
  const HomeProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final subtitle = (product.description ?? '').isNotEmpty
        ? product.description!
        : 'Catalog: ${product.code}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 160,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: (product.image ?? '').isNotEmpty
                    ? Image.network(
                  product.image!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image),
                )
                    : const Icon(Icons.image_not_supported),
              ),
            ),
            const SizedBox(height: 8),
            if ((product.brand ?? '').isNotEmpty)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E6F5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  product.brand!,
                  style: Textstyle.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(height: 6),
            Text(
              product.name,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:  Textstyle.cardTitle
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:Textstyle.cardTitle,
            ),
          ],
        ),
      ),
    );
  }
}