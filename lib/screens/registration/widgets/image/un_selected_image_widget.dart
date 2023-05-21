import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UnSelectedImageWidget extends StatelessWidget {
  const UnSelectedImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: const Icon(
        Ionicons.image_outline,
        size: 60,
      ),
    );
  }
}
