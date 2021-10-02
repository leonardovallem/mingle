import 'package:flutter/material.dart';
import 'package:projects/components/diamond_button.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const AutomaticNotchedShape(RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0)))),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/menu"),
            icon: const Icon(Icons.person_outline,
                size: 32.0, color: Colors.grey),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DiamondButton(
              onClick: () => Navigator.pushNamed(context, "/find"),
              icon: const Icon(Icons.search, size: 48.0, color: Colors.white),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                size: 32.0,
                color: Colors.grey,
              )),
          const Spacer(),
        ],
      ),
    );
  }
}
