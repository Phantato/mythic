import 'package:flutter/material.dart';

import '../model/world_model.dart';

class CharacterListView extends StatefulWidget {
  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  @override
  Widget build(BuildContext context) {
    final newCharacter = Character();

    return ListView.builder(
      itemBuilder: (_, index) => index == 0
          ? _CharacterCard(
              character: newCharacter,
              completer: () => setState(() {
                    characters.add(newCharacter);
                  }))
          : Dismissible(
              key: ObjectKey(characters[characters.length - index]),
              child: _CharacterCard(character: characters[characters.length - index]),
              onDismissed: (_) =>
                  setState(() => characters.removeAt(characters.length - index)),
              background: Container(color: Colors.red),
            ),
      itemCount: characters.length + 1,
    );
  }
}

class _CharacterCard extends StatelessWidget {
  _CharacterCard({required this.character, this.completer});

  final Character character;
  final void Function()? completer;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('标题：'),
                  VerticalDivider(),
                  Expanded(
                    child: TextField(
                      decoration: completer == null
                          ? const InputDecoration()
                          : InputDecoration(
                              border: InputBorder.none, hintText: '新增人物'),
                      controller: TextEditingController(text: character.title),
                      onChanged: (title) => character.title = title,
                      onSubmitted: (str) {
                        if (str.isNotEmpty) {
                          completer?.call();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: completer == null
                          ? TextInputAction.next
                          : TextInputAction.done,
                    ),
                  ),
                ],
              ),
              if (completer == null) Divider(),
              if (completer == null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('细节：'),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: TextEditingController(text: character.detail),
                        onChanged: (detail) => character.detail = detail,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
