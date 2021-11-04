import 'package:flutter/material.dart';

class MingleSnackbar extends SnackBar {
  String text;

  MingleSnackbar(this.text) : super(content: Text(text));

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w400)),
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(12.0),
      backgroundColor: Color(0xFFFDAAAA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    );
  }
}
