import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColor {
  final Color primaryColor = const Color(0xff1A1A1A);

  final Color backgroundColor = Colors.white;
  final Color greyColor = const Color(0xffDCDCDC);

  final Color iconUnselected = const Color(0xffC4C4C4);
  final Color iconSelected = const Color(0xff1A1A1A);

  final Color primaryTextColor = const Color(0xff171717);
  final Color secondaryTextColor = const Color(0xffBCBCBC);

  final Color buttonOutlinePrimary = const Color(0xff1A1A1A);
  final Color buttonFillPrimary = const Color(0xff1A1A1A);

  final Color buttonOutlinePrimaryText = const Color(0xff1A1A1A);
  final Color buttonFillPrimaryText = Colors.white;

  static ThemeColor _instance;

  ThemeColor._();

  ThemeColor();

  ThemeColor get(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return ThemeDarkColor.getInstance;
    } else {
      return ThemeColor.getInstance;
    }
  }

  static ThemeColor get getInstance => _instance = _instance ?? ThemeColor._();
}

class ThemeDarkColor extends ThemeColor {
  final Color greyColor = const Color(0xffBCBCBC);

  static ThemeDarkColor _instance;

  ThemeDarkColor._();

  static ThemeDarkColor get getInstance => _instance = _instance ?? ThemeDarkColor._();
}

final List<Color> colorCategory = [
  Colors.greenAccent,
  const Color(0xffe0e7b5),
  const Color(0xff97904F),
  const Color(0xff49d1ff),
  const Color(0xff5e68ff),
  const Color(0xffedc4bc),
  const Color(0xffE8723D),
  const Color(0xff3DE8C9)
];