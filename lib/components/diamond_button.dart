import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DiamondButton extends StatelessWidget {
  VoidCallback onClick;
  Icon icon;

  DiamondButton({required this.onClick, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(
        pi / 4,
      ),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClick,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(
                pi / 4,
              ),
              child: icon,
            ),
            borderRadius: BorderRadius.circular(24.0),
            splashColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
