import 'package:flutter/material.dart';
import 'package:projects/components/mingle_large_button.dart';
import 'package:projects/components/mingle_scaffold.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum SearchMethod { useOwnIngredients, insertNewIngredients }

class _SearchPageState extends State<SearchPage> {
  SearchMethod? _searchMethod = SearchMethod.useOwnIngredients;

  @override
  Widget build(BuildContext context) {
    return MingleScaffold(
      hideActionBar: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Column(
          children: [
            SearchOption(
              title: Text("usar meus ingredientes cadastrados"),
              onChanged: (newMethod) =>
                  setState(() => _searchMethod = newMethod),
              value: SearchMethod.useOwnIngredients,
              groupValue: _searchMethod!,
            ),
            SearchOption(
              title: Text("inserir ingredientes a serem usados"),
              onChanged: (newMethod) =>
                  setState(() => _searchMethod = newMethod),
              value: SearchMethod.insertNewIngredients,
              groupValue: _searchMethod!,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _searchMethod == SearchMethod.insertNewIngredients
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Color(0x33AA4400)),
                        child: ListView(
                          children: const [
                            Center(
                              child: Text("Em breve", style: TextStyle(
                                fontSize: 24.0
                              )),
                            )
                          ],
                        ),
                      )
                    : null,
              ),
            ),
            MingleLargeButton(label: "Buscar", onClick: () {})
          ],
        ),
      ),
    );
  }
}

class SearchOption extends StatelessWidget {
  Widget title;
  ValueChanged<SearchMethod?> onChanged;
  SearchMethod value;
  SearchMethod groupValue;

  SearchOption({
    required this.title,
    required this.onChanged,
    required this.value,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Color(0xFFDADADA)),
        child: InkWell(
          onTap: () => onChanged(value),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: title,
              leading: Radio<SearchMethod>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
