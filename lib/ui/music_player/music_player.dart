import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/data/model/song.dart';
import 'package:music_app/ui/music_player/audio_player_manager.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    super.key,
    required this.playingSong,
    required this.songs,
  });
  final Song playingSong;
  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return MusicPlayerPage(
      songs: songs,
      playingSong: playingSong,
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    required this.playingSong,
    required this.songs,
  });
  final Song playingSong;
  final List<Song> songs;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _thumbnailAnimController;
  late AudioPlayerManager _audioPlayerManager;

  @override
  void initState() {
    super.initState();
    _audioPlayerManager =
        AudioPlayerManager(songUrl: widget.playingSong.source);
    _audioPlayerManager.init();
    _thumbnailAnimController =
        AnimationController(vsync: this, duration: const Duration(seconds: 12));
  }

  @override
  void dispose() {
    _audioPlayerManager.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const delta = 64;
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: const Text('Music Player'),
          trailing: GestureDetector(
            child: const Icon(
              Icons.more_vert,
              size: 28,
            ),
            onTap: () {},
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            widget.playingSong.album,
            style: const TextStyle(
              inherit: false,
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '_ ___ _',
            style: TextStyle(
              inherit: false,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          RotationTransition(
            turns:
                Tween(begin: 0.0, end: 1.0).animate(_thumbnailAnimController),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                width: screenWidth - delta,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: FadeInImage.assetNetwork(
                    image: widget.playingSong.image,
                    placeholder: 'assets/itunes.png',
                    imageErrorBuilder: (context, error, stackTrace) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          'assets/itunes.png',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Màu nền của container
                borderRadius: BorderRadius.circular(8), // Bo góc (tuỳ chọn)
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.2), // Màu của shadow với độ trong suốt
                    spreadRadius: 1, // Bán kính lan toả
                    blurRadius: 7, // Độ mờ của shadow
                    offset:
                        const Offset(0, 1), // Độ dịch chuyển của shadow (x, y)
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.share,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.playingSong.title,
                              style: const TextStyle(
                                inherit: false,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.playingSong.artist,
                              style: const TextStyle(
                                inherit: false,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.favorite_outline,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Màu nền của container
                borderRadius: BorderRadius.circular(8), // Bo góc (tuỳ chọn)
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 12,
                  right: 12,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    _progressBar(),
                    _mediaButtons(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
        stream: _audioPlayerManager.durationState,
        builder: (context, snapshot) {
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final buffered = durationState?.buffered ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;

          return ProgressBar(
            progress: progress,
            buffered: buffered,
            total: total,
            thumbColor: Theme.of(context).colorScheme.primary,
            thumbRadius: 6,
            thumbGlowRadius: 24,
            baseBarColor: const Color.fromRGBO(128, 128, 128, 0.1),
            bufferedBarColor: const Color.fromRGBO(128, 128, 128, 0.2),
            timeLabelPadding: 4,
            timeLabelTextStyle: const TextStyle(
              inherit: false,
              fontSize: 12,
              color: Colors.grey,
            ),
            onSeek: (value) {
              _audioPlayerManager.player.seek(value);
            },
          );
        });
  }

  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder(
      stream: _audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playState = snapshot.data;
        final processingState = playState?.processingState;
        final playing = playState?.playing;

        if (playing != true) {
          return MediaButtonControl(
            function: () {
              _audioPlayerManager.player.play();
            },
            icon: Icons.play_arrow,
            color: Colors.black,
            size: 40,
          );
        }

        switch (processingState) {
          case ProcessingState.loading:
          case ProcessingState.buffering:
            return const SizedBox(
              width: 48,
              height: 48,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          case ProcessingState.completed:
            return MediaButtonControl(
              function: () {
                _audioPlayerManager.player.seek(Duration.zero);
              },
              icon: Icons.replay,
              color: Colors.black,
              size: 40,
            );
          default:
            return MediaButtonControl(
              function: () {
                _audioPlayerManager.player.pause();
              },
              icon: Icons.pause,
              color: Colors.black,
              size: 40,
            );
        }
      },
    );
  }

  Widget _mediaButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const MediaButtonControl(
              function: null,
              icon: Icons.shuffle,
              color: Colors.grey,
              size: 20,
            ),
            const MediaButtonControl(
              function: null,
              icon: Icons.skip_previous,
              color: Colors.black,
              size: 32,
            ),
            _playButton(),
            const MediaButtonControl(
              function: null,
              icon: Icons.skip_next,
              color: Colors.black,
              size: 32,
            ),
            const MediaButtonControl(
              function: null,
              icon: Icons.repeat,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class MediaButtonControl extends StatefulWidget {
  const MediaButtonControl({
    super.key,
    required this.function,
    required this.icon,
    required this.color,
    required this.size,
  });

  final void Function()? function;
  final IconData icon;
  final Color? color;
  final double? size;

  @override
  State<StatefulWidget> createState() => _MediaButtonControlState();
}

class _MediaButtonControlState extends State<MediaButtonControl> {
  @override
  Widget build(BuildContext context) {
    const double defaultSize = 20;
    double iconSize = widget.size ?? defaultSize;
    double buttonSize = iconSize + 8;
    return IconButton(
      constraints: BoxConstraints(maxHeight: buttonSize, maxWidth: buttonSize),
      padding: EdgeInsets.zero,
      onPressed: widget.function,
      icon: Icon(
        widget.icon,
        color: widget.color ?? Theme.of(context).colorScheme.primary,
      ),
      iconSize: iconSize,
    );
  }
}
