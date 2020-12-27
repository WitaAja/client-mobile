import 'package:flutter/material.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/utils/constant.dart';

ThemeData themeLight(BuildContext context) {
  return ThemeData(
    primaryColor: ThemeColor.getInstance.get(context).primaryColor,
    fontFamily: "Roboto",
    scaffoldBackgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: TextStyle(fontSize: 12),
      backgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: ThemeColor.getInstance.get(context).backgroundColor,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: ThemeColor.getInstance.get(context).iconSelected),
      textTheme: TextTheme(
        caption: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: ThemeColor.getInstance.get(context).primaryTextColor,
        ),
        headline6: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20, fontWeight: FontWeight.w500),
      ),
    ),
    iconTheme: IconThemeData(color: ThemeColor.getInstance.get(context).iconSelected),
    textSelectionColor: ThemeColor.getInstance.get(context).primaryTextColor,
    backgroundColor: ThemeColor.getInstance.get(context).backgroundColor,
    buttonTheme: ButtonThemeData(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      minWidth: 0,
      height: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    primaryTextTheme: TextTheme(
      caption: TextStyle(fontSize: 16, color: ThemeColor.getInstance.get(context).primaryTextColor),
      headline6: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline5: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline4: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline3: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline2: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline1: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      subtitle1: TextStyle(color: ThemeColor.getInstance.get(context).secondaryTextColor, fontSize: 20),
      subtitle2: TextStyle(color: ThemeColor.getInstance.get(context).secondaryTextColor, fontSize: 20),
    ),
    textTheme: TextTheme(
      caption: TextStyle(fontSize: 16, color: ThemeColor.getInstance.get(context).primaryTextColor),
      headline6: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline5: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      headline4: TextStyle(
          color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize38, fontWeight: FontWeight.w500),
      headline3: TextStyle(
        color: ThemeColor.getInstance.get(context).primaryTextColor,
        fontSize: FontSizeResponsive.fontSize33,
      ),
      headline2: TextStyle(
          color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: FontSizeResponsive.fontSize30, fontWeight: FontWeight.w500),
      headline1: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor, fontSize: 20),
      subtitle1: TextStyle(color: ThemeColor.getInstance.get(context).secondaryTextColor, fontSize: FontSizeResponsive.fontSize30),
      subtitle2: TextStyle(color: ThemeColor.getInstance.get(context).secondaryTextColor, fontSize: FontSizeResponsive.fontSize25),
    ),
  );
}
