import 'package:flutter/material.dart';

class CustomProfilePhotoContainer extends StatelessWidget {
  final String image;
  const CustomProfilePhotoContainer({
    super.key,
    required this.image,
    required this.raduis,
  });
  final double raduis;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: raduis,
      height: raduis,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
