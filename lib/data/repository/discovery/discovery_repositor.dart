import 'dart:async';
import 'dart:convert';
import 'package:music_app/data/model/song.dart';
import 'package:music_app/data/repository/discovery/discovery_repositor_impl.dart';
import 'package:http/http.dart' as http;

class DiscoveryRepository implements DiscoveryRepositoryImpl {
  @override
  Future<List<Song>> loadSong() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    try {
      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException(
              "The connection has timed out, please try again.");
        },
      );
      if (response.statusCode == 200) {
        // decode từ bodyBytes chứ không lấy trực tiếp từ body để tránh các kí tự tiếng việt bị encode
        final body = utf8.decode(response.bodyBytes);
        var songWrapper = jsonDecode(body);
        var songList = songWrapper['songs'] as List;
        List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
        return songs;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
