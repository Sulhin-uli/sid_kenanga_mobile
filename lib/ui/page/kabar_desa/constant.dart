import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kgrey1 = Color(0xFF9F9F9F);
const kgrey2 = Color(0xFF6D6D6D);
const kgrey3 = Color(0xFFEAEAEA);
const kBlack = Color(0xFF1C1C1C);

var kNonActiveTabStyle = GoogleFonts.roboto(
  textStyle: TextStyle(fontSize: 14.0, color: kgrey1),
);

var kActiveTabStyle = GoogleFonts.roboto(
  textStyle:
      TextStyle(fontSize: 16.0, color: kBlack, fontWeight: FontWeight.bold),
);

var kCategoryTitle = GoogleFonts.roboto(
  textStyle:
      TextStyle(fontSize: 14.0, color: kgrey2, fontWeight: FontWeight.bold),
);

var kTitleCard = GoogleFonts.roboto(
  textStyle:
      TextStyle(fontSize: 18.0, color: kBlack, fontWeight: FontWeight.bold),
);
