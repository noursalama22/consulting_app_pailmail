import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/logo.png'),
          height: 100,
          width: 100,
        ),
        DefaultTextStyle(
          style: GoogleFonts.arefRuqaa(fontSize: 28, color: Colors.white),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('ديوان رئيس الوزراء'),
            ],
            isRepeatingAnimation: false,
          ),
        ),
        // Text('ديوان رئيس الوزراء',
        //     style: GoogleFonts.arefRuqaa(fontSize: 28, color: Colors.white)),
      ],
    );
  }
}
