import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle n({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = const Color(0xFF333333),
    double height = 1.4,
  }) {
    return GoogleFonts.nunito(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  // Màu chủ đạo
  static const Color Red = Color(0xFFDA2128);
  static const Color Green = Color(0xFF2E7D32);
  static const Color gold = Color(0xFFD4960A);
  static const Color green1 = Color(0xFFBDD753);
  static const Color green2 = Color(0xFF006C32);
}