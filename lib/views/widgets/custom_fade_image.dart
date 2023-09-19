import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

import '../../core/utils/constants.dart';

class CustomFdeImage extends StatelessWidget {
  const CustomFdeImage({
    super.key,
    required this.userImage,
  });

  final String? userImage;

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      // whenever the image changes, it will be loaded, and then faded in:
      image: NetworkImage('$userImage'),
      // slow fade for newly loaded images:
      duration: const Duration(milliseconds: 900),

      // if the image is loaded synchronously (ex. from memory), fade in faster:
      syncDuration: const Duration(milliseconds: 150),

      // supports most properties of Image:
      alignment: Alignment.center,
      fit: BoxFit.cover,

      // shown behind everything:
      placeholder: Container(
        color: kLightGreyColor,
        alignment: Alignment.center,
        child: const Icon(Icons.photo, color: Colors.white70, size: 50.0),
      ),

      // shows progress while loading an image:
      loadingBuilder: (context, progress, chunkEvent) =>
          Center(child: CircularProgressIndicator(value: progress)),

      // displayed when an error occurs:
      errorBuilder: (context, error) => Container(
        color: const Color(0xFF6F6D6A),
        alignment: Alignment.center,
        child: const Icon(Icons.person, color: Colors.black26, size: 50.0),
      ),
    );
  }
}
