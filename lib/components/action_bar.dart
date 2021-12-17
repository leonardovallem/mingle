import 'package:flutter/material.dart';
import 'package:projects/components/diamond_button.dart';
import 'package:projects/config/authentication.dart';

import 'flat_text.dart';

class ActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)))),
      child: Row(
        children: [
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/menu"),
            icon: const Icon(Icons.person_outline, size: 32.0, color: Colors.grey),
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
          FutureBuilder(
            future: isAuthenticated(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Spacer();

              return snapshot.data == true
                  ? IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0, right: 8, top: 16, bottom: 16),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.pink),
                                          padding: EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, "/add/ingredient");
                                      },
                                      child: FlatText("Ingrediente")),
                                )),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 16, top: 16, bottom: 16),
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.pink),
                                          padding: EdgeInsets.symmetric(vertical: 16),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, "/add/recipe");
                                      },
                                      child: FlatText("Receita")),
                                )),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 32.0,
                        color: Colors.grey,
                      ))
                  : Spacer();
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
