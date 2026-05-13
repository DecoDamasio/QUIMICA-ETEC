import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle pageTitle = GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 0, 0, 0),
  );

  static TextStyle buttonText = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}