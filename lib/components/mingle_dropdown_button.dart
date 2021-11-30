import 'package:flutter/material.dart';

class MingleDropdownButton extends StatefulWidget {
  TextEditingController controller;
  String label;
  IconData? icon;

  MingleDropdownButton({required this.label, this.icon, required this.controller});

  @override
  State<MingleDropdownButton> createState() => _MingleDropdownButtonState();
}

class _MingleDropdownButtonState extends State<MingleDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Container(
        width: double.infinity,
        child: PopupMenuButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: () {
                widget.controller.text = "u";
                setState(() => widget.label = "Unidades");
              },
              child: const ListTile(
                leading: Text("u"),
                title: Text('Unidades'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.controller.text = "g";
                setState(() => widget.label = "Gramas");
              },
              child: const ListTile(
                leading: Text("g"),
                title: Text('Gramas'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.controller.text = "kg";
                setState(() => widget.label = "Kilogramas");
              },
              child: const ListTile(
                leading: Text("kg"),
                title: Text('Kilogramas'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.controller.text = "L";
                setState(() => widget.label = "Litros");
              },
              child: const ListTile(
                leading: Text("L"),
                title: Text('Litros'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.controller.text = "cp";
                setState(() => widget.label = "Colheres de sopa");
              },
              child: const ListTile(
                leading: Text("cp"),
                title: Text('Colheres de sopa'),
              ),
            ),
            PopupMenuItem(
              onTap: () {
                widget.controller.text = "cc";
                setState(() => widget.label = "Colheres de chá");
              },
              child: const ListTile(
                leading: Text("cc"),
                title: Text('Colheres de chá'),
              ),
            ),
          ],
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(widget.icon, color: Colors.grey),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                  widget.label,
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xDDAB7979),
                  ),
                ),
                    )),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 5,
                blurRadius: 20,
                offset: Offset(0, 3),
              )
            ]),
      ),
    );
  }
}
