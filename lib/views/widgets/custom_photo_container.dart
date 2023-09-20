import 'package:flutter/material.dart';

class CustomPhotoContainer extends StatelessWidget {
  const CustomPhotoContainer({
    super.key,
    required this.raduis,
    required this.url,
  });
  final double raduis;
  final String url;

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
          image: NetworkImage(
            url,
          ),
        ),
      ),
    );
  }
}
