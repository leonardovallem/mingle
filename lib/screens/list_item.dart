import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  VoidCallback? onClick;
  Widget title;

  ListItem({this.onClick, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          child: ListTile(title: title),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Color(0xFFF0F0F0)
          ),
        ),
      ),
    );
  }
}
