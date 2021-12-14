import 'package:flutter/material.dart';

class CheckboxListButton<T> extends StatefulWidget {
  int quantity;
  String matchingLabel;
  VoidCallback onPressed;

  CheckboxListButton({
    required this.quantity,
    required this.matchingLabel,
    required this.onPressed,
  });

  @override
  State<CheckboxListButton<T>> createState() => _CheckboxListButtonState<T>();
}

class _CheckboxListButtonState<T> extends State<CheckboxListButton<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.35),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 3),
          )
        ]),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child:
                    Text(widget.quantity.toString(), style: const TextStyle(color: Colors.pink, fontSize: 24, fontWeight: FontWeight.w400)),
              ),
              Text(
                widget.matchingLabel,
                style: const TextStyle(color: Color(0xDDAB7979), fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(32),
              primary: Color(0xFFFAFAFA),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
        ),
      ),
    );
  }
}
