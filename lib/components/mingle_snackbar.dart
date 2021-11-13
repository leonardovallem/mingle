import 'package:flutter/material.dart';

class MingleSnackbar extends SnackBar {
  Widget content;
  Duration duration = Duration(seconds: 3);

  MingleSnackbar({required this.content, duration}) : super(content: content, duration: duration);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(12.0),
      backgroundColor: Color(0xFFFDAAAA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      duration: duration,
    );
  }
}
