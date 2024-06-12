import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

mixin CustomFontStyle {

  static TextStyle heading = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontSize: kIsWeb ? 4.sp : 16.sp,
      fontWeight: FontWeight.bold,
      color: Colors.brown,
      letterSpacing: 1,
    ),
  );

  static TextStyle normal = GoogleFonts.roboto(
      textStyle: TextStyle(fontSize:kIsWeb ? 4.sp : 12.sp, fontWeight: FontWeight.normal));

  static TextStyle med = GoogleFonts.roboto(
      textStyle: TextStyle(fontSize:kIsWeb ? 6.sp : 14.sp, fontWeight: FontWeight.bold,letterSpacing: 1,));



}