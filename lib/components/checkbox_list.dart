import 'package:flutter/material.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/mingle_text_input.dart';
import 'package:projects/util/list_items_controller.dart';

class CheckboxList<T> extends StatefulWidget {
  String title;
  List<T> items;
  bool canAdd;
  String? addLabel;
  ListItemsController? controller;
  VoidCallback? update;

  CheckboxList({
    required this.title,
    required this.items,
    this.canAdd = false,
    this.addLabel,
    this.controller,
    this.update,
  });

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: widget.title,
      hideActionBar: true,
      appBarActions: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MingleTextInput(
                        maxLines: widget.canAdd ? 5 : 1,
                        label: widget.canAdd
                            ? (widget.addLabel ?? "Adicionar")
                            : "Pesquisar",
                        icon: Icon(widget.canAdd ? Icons.add : Icons.search),
                        onSubmitted: (value) {
                          setState(() => widget.controller!.items.add(value));
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          if (widget.update != null) widget.update!();
                        },
                      ),
                      Text("Deslize para baixo para cancelar")
                    ],
                  ),
                  duration: Duration(days: 999),
                ));
              },
              icon: Icon(widget.canAdd ? Icons.add : Icons.search),
            ))
      ],
      body: ListView.builder(
          itemCount: widget.canAdd
              ? widget.controller!.items.length
              : widget.items.length,
          itemBuilder: (context, index) {
            return widget.canAdd
                ? ListTile(
                    title: Text(widget.controller!.items[index]),
                    subtitle: Text("Passo #${index + 1}"),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => setState(() {
                          widget.controller!.items.removeAt(index);
                          if(widget.update != null) widget.update!();
                        }),
                  ))
                : CheckboxListItem(
                    title: widget.items[index].toString(),
                    value:
                        widget.controller!.items.contains(widget.items[index]),
                    onChanged: (value) {
                      bool contains = widget.controller!.items
                          .any((value) => widget.items[index] == value);

                      if (contains && value) return;
                      if (!contains && !value) return;

                      if (value)
                        widget.controller!.items.add(widget.items[index]);
                      else
                        widget.controller!.items.remove(widget.items[index]);
                      if (widget.update != null) widget.update!();
                    });
          }),
    );
  }
}

class CheckboxListItem extends StatefulWidget {
  String title;
  bool? value;
  ValueChanged<bool>? onChanged;

  CheckboxListItem({required this.title, this.value = false, this.onChanged});

  @override
  State<CheckboxListItem> createState() => _CheckboxListItemState();
}

class _CheckboxListItemState extends State<CheckboxListItem> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.value,
      onChanged: (value) {
        setState(() {
          widget.value = value ?? false;
          if (widget.onChanged != null) widget.onChanged!(widget.value!);
        });
      },
      title: Text(widget.title),
    );
  }
}
