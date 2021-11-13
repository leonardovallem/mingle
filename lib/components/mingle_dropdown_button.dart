import 'package:flutter/material.dart';

class MingleDropdownButton extends StatelessWidget {
  String label;
  IconData? icon;

  MingleDropdownButton({required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Container(
        width: double.infinity,
        child: PopupMenuButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              child: ListTile(
                leading: Text("g"),
                title: Text('Gramas'),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Text("kg"),
                title: Text('Kilogramas'),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Text("L"),
                title: Text('Litros'),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
                leading: Text("cp"),
                title: Text('Colheres de Sopa'),
              ),
            ),
            const PopupMenuItem(
              child: ListTile(
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
                  child: Icon(icon, color: Colors.grey),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                  label,
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
