import 'package:music_app/data/model/song.dart';
import 'package:music_app/data/source/source.dart';

abstract interface class Repository {
  Future<List<Song>?> loadData();
}

class DefaultRepository implements Repository {
  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    try {
      var remoteSongs = await _remoteDataSource.loadData();
      if (remoteSongs != null) {
        songs.addAll(remoteSongs);
      } else {
        var localSongs = await _localDataSource.loadData();
        if (localSongs != null) {
          songs.addAll(localSongs);
        }
      }
    } catch (e) {
      print(e);
    }
    return songs;
  }
}
