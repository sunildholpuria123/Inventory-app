import 'dart:io';

import 'package:flutter/material.dart';

class ProductImageWidget
    extends StatelessWidget {
  final String? imagePath;

  final double size;

  const ProductImageWidget({
    super.key,
    required this.imagePath,
    this.size = 50,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    if (imagePath == null) {
      return CircleAvatar(
        radius: size / 2,

        child: const Icon(
          Icons.image,
        ),
      );
    }

    return ClipRRect(
      borderRadius:
      BorderRadius.circular(
        8,
      ),

      child: Image.file(
        File(imagePath!),

        width: size,
        height: size,

        fit: BoxFit.cover,

        errorBuilder:
            (_, __, ___) {
          return CircleAvatar(
            radius: size / 2,

            child: const Icon(
              Icons.broken_image,
            ),
          );
        },
      ),
    );
  }
}