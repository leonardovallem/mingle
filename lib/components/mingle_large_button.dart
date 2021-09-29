import 'package:flutter/material.dart';

class MingleLargeButton extends StatelessWidget {
  String label;
  VoidCallback onClick;

  MingleLargeButton({required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            primary: Colors.pinkAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: Text(label, style: const TextStyle(fontSize: 18.0)),
          ),
        ),
      ),
    );
  }
}
