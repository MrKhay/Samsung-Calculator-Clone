import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/strings.dart';

class CustomTextEditingController extends TextEditingController {
  CustomTextEditingController({super.text});

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<String> specialCharacters = ["+", "%", "-", "x", "÷", "^"];
    List<String> textSegments = text.split(" ");
    final customFontStyle = GoogleFonts.nunito(
        fontWeight: FontWeight.w700,
        color: greenColor,
        fontSize: style!.fontSize);

    List<TextSpan> textSpans = [];
    for (int i = 0; i < textSegments.length; i++) {
      String segment = textSegments[i];
      if (specialCharacters.contains(segment)) {
        textSpans.add(TextSpan(text: segment, style: customFontStyle));
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
            textSpans.add(TextSpan(text: specialChar, style: customFontStyle));
            index = specialCharIndex + 1;
          }
        }
      }
      if (i < textSegments.length - 1) {
        textSpans.add(TextSpan(text: " ", style: style));
      }
    }

    return TextSpan(children: textSpans, style: style);
  }
}
