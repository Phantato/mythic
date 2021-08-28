import 'package:flutter/material.dart';

import '../model/story_model.dart';

class SceneListView extends StatefulWidget {
  @override
  _SceneListViewState createState() => _SceneListViewState();
}

class _SceneListViewState extends State<SceneListView> {
  @override
  Widget build(BuildContext context) {
    final newScene = Scene();

    return ListView.builder(
      itemBuilder: (_, index) => index == 0
          ? _SceneCard(
              scene: newScene,
              completer: () => setState(() {
                    scenes.add(newScene);
                  }))
          : Dismissible(
              key: ObjectKey(scenes[scenes.length - index]),
              child: _SceneCard(scene: scenes[scenes.length - index]),
              onDismissed: (_) =>
                  setState(() => scenes.removeAt(scenes.length - index)),
              background: Container(color: Colors.red),
            ),
      itemCount: scenes.length + 1,
    );
  }
}

class _SceneCard extends StatelessWidget {
  _SceneCard({required this.scene, this.completer});

  final Scene scene;
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
                              border: InputBorder.none, hintText: '新增场景'),
                      controller: TextEditingController(text: scene.title),
                      onChanged: (title) => scene.title = title,
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
                        controller: TextEditingController(text: scene.detail),
                        onChanged: (detail) => scene.detail = detail,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
