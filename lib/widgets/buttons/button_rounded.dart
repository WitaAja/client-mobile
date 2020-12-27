import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedOutlineButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Widget prefixIcon;
  final Color colorBorder;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const RoundedOutlineButton(
      {@required this.onPressed, this.text, this.prefixIcon, this.colorBorder, this.textStyle, this.padding, this.margin = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: OutlineButton(
        padding: padding,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        highlightedBorderColor: colorBorder,
        color: colorBorder,
        focusColor: colorBorder,
        disabledBorderColor: colorBorder,
        borderSide: BorderSide(color: colorBorder, width: 1, style: BorderStyle.solid),
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: onPressed,
        child: prefixIcon == null
            ? Text(
                text,
                style: textStyle,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    prefixIcon,
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Text(
                        text,
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class RoundedFillButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Widget prefixIcon;
  final Color colorBorder;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const RoundedFillButton(
      {@required this.onPressed, this.text, this.prefixIcon, this.colorBorder, this.textStyle, this.padding, this.margin = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: RaisedButton(
        padding: padding,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        highlightElevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: onPressed,
        color: colorBorder,
        child: prefixIcon == null
            ? Text(
                text,
                style: textStyle,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    prefixIcon,
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Text(
                        text,
                        style: textStyle,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
