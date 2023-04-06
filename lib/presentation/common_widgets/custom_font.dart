import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle customFont({
  double? fontSize = 16,
  FontWeight? fontWeight = FontWeight.normal,
  Color? color = Colors.white,
}) {
  return GoogleFonts.nunito(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey);
}
