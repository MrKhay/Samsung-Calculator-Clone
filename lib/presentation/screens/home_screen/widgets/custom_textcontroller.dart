import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/strings.dart';

class CustomTextEditingController extends TextEditingController {
  CustomTextEditingController({super.text});

  final List<String> specialCharacters = ["+", "%", "-", "x", "÷"];

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<String> textSegments = text.split(" ");
    final customStyle = GoogleFonts.nunito(
        fontWeight: FontWeight.w700,
        color: primaryColor,
        fontSize: style!.fontSize);

    List<TextSpan> textSpans = [];
    for (int i = 0; i < textSegments.length; i++) {
      String segment = textSegments[i];
      if (specialCharacters.contains(segment)) {
        textSpans.add(TextSpan(text: segment, style: customStyle));
      } else {
        int index = 0;
        while (index < segment.length) {
          int specialCharIndex = -1;
          for (int j = 0; j < specialCharacters.length; j++) {
            int tempIndex = segment.indexOf(specialCharacters[j], index);
            if (tempIndex != -1 &&
                (specialCharIndex == -1 || tempIndex < specialCharIndex)) {
              specialCharIndex = tempIndex;
            }
          }
          if (specialCharIndex == -1) {
            textSpans
                .add(TextSpan(text: segment.substring(index), style: style));
            break;
          } else {
            if (specialCharIndex > index) {
              textSpans.add(TextSpan(
                  text: segment.substring(index, specialCharIndex),
                  style: style));
            }
            String specialChar =
                segment.substring(specialCharIndex, specialCharIndex + 1);
            textSpans.add(TextSpan(text: specialChar, style: customStyle));
            index = specialCharIndex + 1;
          }
        }
      }
      if (i < textSegments.length - 1) {
        textSpans.add(TextSpan(text: " ", style: style));
      }
    }

    return TextSpan(children: textSpans);
  }
}
