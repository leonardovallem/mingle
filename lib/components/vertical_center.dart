import 'package:flutter/material.dart';

class VerticalCenter extends StatelessWidget {
  Widget child;

  VerticalCenter({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [child],
    );
  }
}
