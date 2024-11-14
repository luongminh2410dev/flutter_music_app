import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/data/model/song.dart';
import 'package:music_app/data/repository/discovery/discovery_repositor.dart';

class DiscoveryTab extends StatefulWidget {
  const DiscoveryTab({super.key});

  @override
  State<DiscoveryTab> createState() => _DiscoveryTabState();
}

class _DiscoveryTabState extends State<DiscoveryTab> {
  List<Song> _songs = [];
  bool isLoading = false;
  final discoveryRepository = DiscoveryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text('Discovery'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _songs.isEmpty
                ? Center(
                    child: ElevatedButton(
                      onPressed: getDataFromInternet,
                      child: const Text('GET DATA FROM INTERNET'),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, position) {
                      return Text(_songs[position].title);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 0.1,
                        indent: 0,
                        endIndent: 0,
                      );
                    },
                    itemCount: _songs.length,
                    shrinkWrap: true,
                  ));
  }

  void getDataFromInternet() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Song> songList = await discoveryRepository.loadSong();
      setState(() {
        _songs.addAll(songList);
      });
    } catch (e) {
      debugPrint("ERROR: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
