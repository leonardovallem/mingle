import 'package:flutter/material.dart';
import 'package:projects/components/diamond_button.dart';
import 'package:projects/components/mingle_snackbar.dart';

import 'flat_text.dart';

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
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(MingleSnackbar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: () {
                              ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              Navigator.pushNamed(context, "/add/ingredient");
                            }, child: FlatText("Ingrediente")),
                          )),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: () {
                              ScaffoldMessenger.of(context).removeCurrentSnackBar();
                              Navigator.pushNamed(context, "/add/recipe");
                            }, child: FlatText("Receita")),
                          )),
                        ],
                      ),
                      Text("Deslize para baixo para cancelar")
                    ],
                  ),
                  duration: Duration(days: 999),
                ));
              },
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
