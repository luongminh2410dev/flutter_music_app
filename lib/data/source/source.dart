import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:music_app/data/model/song.dart';
import 'package:http/http.dart' as http;

// Future<List<Song>?> -> dấu ? để báo giá trị trả ra của hàm có thể null
abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      // decode từ bodyBytes chứ không lấy trực tiếp từ body để tránh các kí tự tiếng việt bị encode
      final body = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(body);
      var songList = songWrapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else {
      return null;
    }
  }
}

class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    final String response = await rootBundle.loadString('assets/songs.json');
    final body = jsonDecode(response);
    final songList = body['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }
}
