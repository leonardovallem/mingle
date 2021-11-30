import 'package:flutter/material.dart';

class MingleTextInput extends StatelessWidget {
  String label;
  Icon icon;
  TextInputType? keyboardType;
  TextEditingController? controller;
  FormFieldValidator? validator;
  int? maxLines;
  ValueChanged<String>? onSubmitted;

  MingleTextInput({
    required this.label,
    required this.icon,
    this.keyboardType,
    this.controller,
    this.validator,
    this.maxLines,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Container(
        child: TextFormField(
          onFieldSubmitted: onSubmitted,
          textInputAction: onSubmitted == null ?  TextInputAction.newline : TextInputAction.done,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: Colors.deepOrangeAccent,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isCollapsed: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 16.0),
              child: icon,
            ),
            contentPadding: EdgeInsets.all(32.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Color(0xFFFAFAFA),
            hintText: this.label,
            hintStyle: TextStyle(color: Color(0xDDAB7979)),
            focusColor: Colors.deepOrangeAccent,
          ),
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 3),
          )
        ]),
      ),
    );
  }
}
