import 'dart:async';

import 'package:music_app/data/model/song.dart';
import 'package:music_app/data/repository/repository.dart';

class MusicAppViewModal {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs() {
    final repository = DefaultRepository();
    repository
        .loadData()
        .then((value) => {songStream.add(value!)})
        .catchError((error) => {print(error)});
  }
}
