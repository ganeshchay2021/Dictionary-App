import 'package:flutter/material.dart';

TextStyle myTextStyle(
    {double? fontsize,
    double? height,
    Color? color,
    FontWeight fontweight = FontWeight.normal}) {
  return TextStyle(
    fontSize: fontsize,
    height: height,
    color: color,
    fontWeight: fontweight,
  );
}
