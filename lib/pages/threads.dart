import 'package:flutter/material.dart';

import '../model/story_model.dart';

class ThreadListView extends StatefulWidget {
  @override
  _ThreadListViewState createState() => _ThreadListViewState();
}

class _ThreadListViewState extends State<ThreadListView> {
  @override
  Widget build(BuildContext context) {
    final newThread = Thread();

    return ListView.builder(
      itemBuilder: (_, index) => index == 0
          ? _Thread(
              thread: newThread,
              completer: () => setState(() {
                    threads.add(newThread);
                  }))
          : Dismissible(
              key: ObjectKey(threads[threads.length - index]),
              child: _Thread(thread: threads[threads.length - index]),
              onDismissed: (_) =>
                  setState(() => threads.removeAt(threads.length - index)),
              background: Container(color: Colors.red),
            ),
      itemCount: threads.length + 1,
    );
  }
}

class _Thread extends StatelessWidget {
  _Thread({required this.thread, this.completer});

  final Thread thread;
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
                              border: InputBorder.none, hintText: '新增线索'),
                      controller: TextEditingController(text: thread.title),
                      onChanged: (title) => thread.title = title,
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
                        controller: TextEditingController(text: thread.detail),
                        onChanged: (detail) => thread.detail = detail,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
