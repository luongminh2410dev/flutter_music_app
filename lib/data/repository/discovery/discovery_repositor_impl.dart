import 'package:music_app/data/model/song.dart';

abstract class DiscoveryRepositoryImpl {
  Future<List<Song>> loadSong();
}
