import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Text('ديوان رئيس الوزراء',
            style: GoogleFonts.sansita(fontSize: 28, color: Colors.white)),
      ],
    );
  }
}
