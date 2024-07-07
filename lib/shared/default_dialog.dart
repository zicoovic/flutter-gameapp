import 'package:flutter/material.dart';
import 'package:flutter_masterclass/shared/styled_button.dart';
import 'package:flutter_masterclass/shared/styled_text.dart';
import 'package:flutter_masterclass/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<dynamic> defaultDialog(String title, String content) {
  return Get.defaultDialog(
    title: title,
    titleStyle: GoogleFonts.kanit(
        textStyle: Theme.of(Get.context!).textTheme.titleMedium),
    content: StyledText(content),
    backgroundColor: Theme.of(Get.context!).dialogTheme.backgroundColor,
    confirm: StyledButton(
      onPressed: () => Get.back(),
      child: const StyledHeading('Ok'),
    ),
    confirmTextColor: AppColors.secondaryColor,
    radius: 10,
  );
}
