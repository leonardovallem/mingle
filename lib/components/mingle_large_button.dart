import 'package:flutter/material.dart';

class MingleLargeButton extends StatelessWidget {
  String label;
  VoidCallback onClick;
  Color? color;
  IconData? icon;

  MingleLargeButton({required this.label, required this.onClick, this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onClick,
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.pinkAccent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(icon != null) Spacer(),
                if(icon != null) Icon(icon),
                if(icon != null) Spacer(),
                if(icon != null) Spacer(),
                Text(label, style: const TextStyle(fontSize: 18.0)),
                if(icon != null) Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
