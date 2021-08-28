import 'package:flutter/material.dart';

import '../model/world_model.dart';

class LocationListView extends StatefulWidget {
  @override
  _LocationListViewState createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {
  @override
  Widget build(BuildContext context) {
    final newLocation = Location();

    return ListView.builder(
      itemBuilder: (_, index) => index == 0
          ? _LocationCard(
              location: newLocation,
              completer: () => setState(() {
                    locations.add(newLocation);
                  }))
          : Dismissible(
              key: ObjectKey(locations[locations.length - index]),
              child: _LocationCard(location: locations[locations.length - index]),
              onDismissed: (_) =>
                  setState(() => locations.removeAt(locations.length - index)),
              background: Container(color: Colors.red),
            ),
      itemCount: locations.length + 1,
    );
  }
}

class _LocationCard extends StatelessWidget {
  _LocationCard({required this.location, this.completer});

  final Location location;
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
                              border: InputBorder.none, hintText: '新增地点'),
                      controller: TextEditingController(text: location.title),
                      onChanged: (title) => location.title = title,
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
                        controller: TextEditingController(text: location.detail),
                        onChanged: (detail) => location.detail = detail,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
