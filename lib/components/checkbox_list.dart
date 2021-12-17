import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:projects/components/mingle_scaffold.dart';
import 'package:projects/components/search_list.dart';
import 'package:projects/config/toggles.dart';
import 'package:projects/model/dto/ingredient_dto.dart';
import 'package:projects/util/list_items_controller.dart';

class CheckboxList<T> extends StatefulWidget {
  String title;
  List<T> items;
  bool canAdd;
  String? addLabel;
  ListItemsController? controller;
  ListItemsController? searchedItemsController;
  VoidCallback? update;

  CheckboxList({
    required this.title,
    required this.items,
    this.canAdd = false,
    this.addLabel,
    this.controller,
    this.searchedItemsController,
    this.update,
  });

  @override
  State<CheckboxList> createState() => _CheckboxListState<T>();
}

class _CheckboxListState<T> extends State<CheckboxList> {
  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      title: widget.title,
      hideActionBar: true,
      appBarActions: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                if (!widget.canAdd) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchIngredients(controller: widget.searchedItemsController!),
                  ));

                  return;
                }

                var preparationStepController = TextEditingController();

                await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Adicionar"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          actions: [
                            SimpleDialogOption(child: Text("Cancelar"), onPressed: () => Navigator.pop(context)),
                            SimpleDialogOption(
                                child: Text("Adicionar", style: TextStyle(color: Colors.pink)),
                                onPressed: () {
                                  setState(() => widget.controller!.items.add(preparationStepController.text));
                                  if (widget.update != null) widget.update!();
                                  Navigator.pop(context);
                                }),
                          ],
                          content: TextFormField(
                            minLines: 5,
                            maxLines: 8,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "Etapa de preparação",
                              labelStyle: TextStyle(color: Colors.pink),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.black12,
                            ),
                            cursorColor: Colors.pink,
                            controller: preparationStepController,
                          ),
                        ));
              },
              icon: Icon(widget.canAdd ? Icons.add : Icons.search),
            ))
      ],
      body: SafeArea(
        child: ListView.builder(
            itemCount: widget.canAdd ? widget.controller!.items.length : widget.items.length,
            itemBuilder: (context, index) {
              return widget.canAdd
                  ? ListTile(
                      title: Text(widget.controller!.items[index]),
                      subtitle: Text("Passo #${index + 1}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => setState(() {
                          widget.controller!.items.removeAt(index);
                          if (widget.update != null) widget.update!();
                        }),
                      ))
                  : UsedIngredientCheckbox(
                      checked: widget.controller!.items.any((element) => element == widget.items[index]),
                      value: widget.items[index],
                      onChanged: (value, checked) {
                        var items = widget.controller!.items as List<IngredientDTO>;

                        bool contains = items.any((val) => value == val);

                        if (contains && checked) return;
                        if (!contains && !checked) return;

                        if (checked)
                          items.add(value);
                        else
                          items.remove(value);
                        if (widget.update != null) widget.update!();
                      });
            }),
      ),
    );
  }
}

typedef ValuesChanged<T, U> = void Function(T t, U u);

class UsedIngredientCheckbox extends StatefulWidget {
  IngredientDTO value;
  bool checked;
  ValuesChanged<IngredientDTO, bool>? onChanged;

  UsedIngredientCheckbox({this.checked = false, this.onChanged, required this.value});

  @override
  State<UsedIngredientCheckbox> createState() => _UsedIngredientCheckboxState();
}

class _UsedIngredientCheckboxState extends State<UsedIngredientCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.checked ? Colors.white : Colors.black12,
          borderRadius: BorderRadius.circular(16),
          border: widget.checked ? Border.all(color: Colors.pink, width: 4) : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (widget.onChanged != null) widget.onChanged!(widget.value, !widget.checked);
            setState(() => widget.checked = !widget.checked);
          },
          child: Container(
            height: 80,
            padding: EdgeInsets.symmetric(horizontal: widget.checked ? 20 : 24, vertical: widget.checked ? 4 : 8),
            child: Row(
              children: [
                Expanded(child: Text(widget.value.name, style: TextStyle(fontSize: 22, color: Colors.black87))),
                if (Toggles.partitionedIngredientsActive)
                  Expanded(
                      child: widget.checked
                          ? Row(children: const [
                              /* TODO */
                            ])
                          : Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text("Você tem:", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w500)),
                              ),
                              Text(
                                """widget.value.quantity
                                    .toStringAsFixed(widget.value.quantity.truncateToDouble() == widget.value.quantity ? 0 : 1)""",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("widget.value.unit",
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 20)),
                              )
                            ]))
              ],
            ),
          ),
        ),
      ),
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
