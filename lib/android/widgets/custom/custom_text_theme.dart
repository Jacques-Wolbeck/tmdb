import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTheme extends TextTheme {
  CustomTextTheme()
      : super(
          headline1: GoogleFonts.poppins(fontSize: 93.0),
          headline2: GoogleFonts.poppins(fontSize: 58.0),
          headline3: GoogleFonts.poppins(fontSize: 58.0),
          headline4: GoogleFonts.poppins(fontSize: 46.0),
          headline5: GoogleFonts.poppins(fontSize: 23.0),
          headline6: GoogleFonts.poppins(fontSize: 19.0),
          bodyText1: GoogleFonts.poppins(fontSize: 15.0),
          bodyText2: GoogleFonts.poppins(fontSize: 13.0),
          subtitle1: GoogleFonts.poppins(fontSize: 15.0),
          subtitle2: GoogleFonts.poppins(fontSize: 13.0),
          button: GoogleFonts.poppins(fontSize: 13.0),
          overline: GoogleFonts.poppins(fontSize: 10.0),
          caption: GoogleFonts.poppins(fontSize: 12.0),
        );
}
