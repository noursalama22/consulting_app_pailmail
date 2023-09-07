import 'package:flutter/material.dart';

class CustomPhotoContainer extends StatelessWidget {
  final String image;
  const CustomPhotoContainer({
    super.key,
    required this.image, required this.raduis,
  });
  final double raduis;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: raduis,
      height: raduis,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            image,
          ),
        ),
      ),
    );
  }
}
