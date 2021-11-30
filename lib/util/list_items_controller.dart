import 'package:flutter/material.dart';

class ListItemsController<T> extends ChangeNotifier {
  List<T> items = [];
}

abstract class ComparableObject {
  bool equals(ComparableObject object);
}