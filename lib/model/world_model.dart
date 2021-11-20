import '../db/db.dart';

List<Character>? characters;
List<Location> locations = [];

class Character {
  int? id;
  String title, detail;
  Character({this.id, this.title = '', this.detail = ''});
  Character.fromMap(Map<String, Object?> m)
      : id = m['id'] as int?,
        title = m['title'] as String,
        detail = m['detail'] as String;
  Map<String, Object?> toMap() => {'id': id, 'title': title, 'detail': detail};
}

class Location {
  String title, detail;
  Location({this.title = '', this.detail = ''});
}
