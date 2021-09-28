import 'dart:math';
import 'package:flutter/material.dart';

class DiamondButton extends StatelessWidget {
  VoidCallback onClick;

  DiamondButton({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(
          pi / 4,
        ),
        child: ElevatedButton(
          onPressed: onClick,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(
              pi / 4,
            ),
            child: const Icon(Icons.arrow_upward_rounded),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrangeAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
            ),
          ),
        ),
      ),
    );
  }
}