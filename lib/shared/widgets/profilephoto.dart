
import 'package:flutter/material.dart';

import '../../core/values/assets.dart';

class ProfilePhoto extends StatelessWidget {
  final VoidCallback? onCameraTap;
  final String? imageUrl;
  final bool isLoading;
  final double imageSize;
  final bool showEditButton;
  const ProfilePhoto({
    super.key,
    this.onCameraTap,
    this.imageUrl,
    this.isLoading = false,
    this.imageSize = 115,
    this.showEditButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasUrl = imageUrl != null && imageUrl!.isNotEmpty;

    return SizedBox(
      height:imageSize,
      width: imageSize,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // CircleAvatar(
          //   radius: imageSize / 2,
          //   backgroundImage: hasUrl
          //       ? NetworkImage(imageUrl!) as ImageProvider
          //       : AssetImage(Assets.photo2),
          //   onBackgroundImageError: hasUrl ? (_, __) {} : null,
          // ),
          CircleAvatar(
            radius: imageSize / 2,
            backgroundImage: hasUrl && imageUrl!.isNotEmpty
                ? NetworkImage(imageUrl!)
                :  AssetImage(Assets.photo2) as ImageProvider,
            onBackgroundImageError: hasUrl ? (_, __) {} : null,
          ),
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
          if (showEditButton)
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: isLoading ? null : onCameraTap,
                child: const Icon(
                  Icons.edit,
                  color: Color(0xFF757575),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}