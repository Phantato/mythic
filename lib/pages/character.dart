import 'package:flutter/material.dart';
import 'package:mythic/db/db.dart';
import 'package:sqflite/sqflite.dart';

import '../model/world_model.dart';

class CharacterListView extends StatefulWidget {
  late final Database db;

  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    widget.db = await database;
    final result = (await widget.db.query('CHARACTER'));
    characters = result.map((map) => Character.fromMap(map)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final newCharacter = Character();
    return ListView.builder(
      itemBuilder: (_, index) {
        if (index == 0) {
          return _CharacterCard(
              character: newCharacter,
              completer: () => _insertCharacter(newCharacter));
        }
        final cs = characters!;
        final oldCharacter = cs[cs.length - index];
        return Dismissible(
          key: ValueKey(oldCharacter.id!),
          child: _CharacterCard(
            character: oldCharacter,
            completer: () => _updateCharacter(oldCharacter),
          ),
          onDismissed: (_) => _removeCharacter(oldCharacter),
          background: Container(color: Colors.red),
        );
      },
      itemCount: (characters?.length ?? 0) + 1,
    );
  }

  _insertCharacter(Character c) async {
    characters?.add(c);
    c.id = await widget.db.insert('CHARACTER', c.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {});
  }

  _updateCharacter(Character c) async {
    await widget.db
        .update('CHARACTER', c.toMap(), where: 'id = ?', whereArgs: [c.id!]);
    setState(() {});
  }

  _removeCharacter(Character c) async {
    characters?.removeWhere((element) => element.id == c.id!);
    await widget.db.delete('CHARACTER', where: 'id = ?', whereArgs: [c.id!]);
    setState(() {});
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
                      decoration: character.id != null
                          ? const InputDecoration()
                          : InputDecoration(
                              border: InputBorder.none, hintText: '新增人物'),
                      controller: TextEditingController(text: character.title),
                      onChanged: (title) => character.title = title,
                      onSubmitted: (str) {
                        if (character.id != null || str.isNotEmpty) {
                          completer?.call();
                        }
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: character.id != null
                          ? TextInputAction.next
                          : TextInputAction.done,
                    ),
                  ),
                ],
              ),
              if (character.id != null) Divider(),
              if (character.id != null)
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
                        controller:
                            TextEditingController(text: character.detail),
                        onChanged: (detail) => character.detail = detail,
                        onSubmitted: (_) => completer?.call(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
