import 'package:flutter/material.dart';

class SizeUtils {
  late double sizeHeight = double.infinity;
  late double sizeWidth = double.infinity;
  late double titleFontSize = 20;
  late double subTitleFontSize = 10;
  late double errorFontSize = 10;
  late double borderRadiusInput = 10;
  SizeUtils(BuildContext context) {
    sizeHeight = MediaQuery.of(context).size.height;
    sizeWidth = MediaQuery.of(context).size.width;

    titleFontSize = sizeWidth * 0.1;
    subTitleFontSize = sizeWidth * 0.05;
    errorFontSize = subTitleFontSize * 0.8;
  }
}
