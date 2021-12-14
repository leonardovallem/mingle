import 'package:flutter/material.dart';

class FlatText extends StatelessWidget {
  String text;

  FlatText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400),
    );
  }
}
