import 'dart:io';

import 'package:flutter/material.dart';

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget({
    super.key,
    required this.imageFile,
  });
  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: FileImage(
            imageFile,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
