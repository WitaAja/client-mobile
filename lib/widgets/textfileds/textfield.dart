import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/utils/constant.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) validator;
  final Function(String) onChanged;
  final String label;
  final EdgeInsets padding;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final List<TextInputFormatter> inputFormatter;

  const TextFieldWidget(
      {this.controller,
      this.validator,
      this.onChanged,
      this.label,
      this.padding = EdgeInsets.zero,
      this.maxLines,
      this.minLines,
      this.maxLength,
      this.inputFormatter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: inputFormatter,
        controller: controller,
        style: TextStyle(color: ThemeColor.getInstance.get(context).primaryTextColor),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.subtitle1,
          errorStyle: TextStyle(fontSize: FontSizeResponsive.fontSize26),
          isDense: true,
          // hintText: hintText,
        ),
      ),
    );
  }
}
