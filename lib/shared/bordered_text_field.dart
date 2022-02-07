import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderedTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final String labelText;
  final int maxLines;
  final int maxLength;
  final bool isPassword;
  final bool? isEnabled;
  final Widget? suffixIcon;
  final TextInputType inputType;
  final String hintText;
  final Function(String) onChanged;
  final Function? onFieldSubmitted;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final bool autoFocus;
  final TextInputAction action;

  // ignore: use_key_in_widget_constructors
  const BorderedTextField(
      {this.focusNode,
      this.controller,
      this.hintStyle,
      this.isEnabled,
      this.onEditingComplete,
      required this.labelText,
      this.isPassword = false,
      this.validator,
      this.onFieldSubmitted,
      this.suffixIcon,
      this.inputType = TextInputType.name,
      this.hintText = "",
      required this.onChanged,
      this.maxLines = 1,
      this.autoFocus = false,
      this.action = TextInputAction.next,
      this.maxLength = 50});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      controller: controller,
      enabled: isEnabled == null ? true : false,
      autovalidateMode: AutovalidateMode.disabled,
      onEditingComplete: onEditingComplete,
      validator: validator,
      focusNode: focusNode,
      obscureText: isPassword,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        suffixIcon: suffixIcon,
        hintStyle: hintStyle,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.black, width: 0.5),
        ),
        hintText: hintText,
        counterText: '',
      ),
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: inputType,
      textInputAction: action,
      onChanged: onChanged,
      textAlign: TextAlign.start,
    );
  }
}
