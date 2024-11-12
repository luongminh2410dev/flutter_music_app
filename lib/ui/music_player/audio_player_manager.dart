import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });

  final Duration progress;
  final Duration buffered;
  final Duration? total;
}

class AudioPlayerManager {
  AudioPlayerManager({
    required this.songUrl,
    required this.songUrls,
  });

  List<String> songUrls;
  String songUrl;
  final player = AudioPlayer();
  Stream<DurationState>? durationState;

  void init() {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
      player.positionStream,
      player.playbackEventStream,
      (position, playbackEvent) => DurationState(
        progress: position,
        buffered: playbackEvent.bufferedPosition,
        total: playbackEvent.duration,
      ),
    );
    final initIndex = songUrls.indexOf(songUrl);
    final playlist = ConcatenatingAudioSource(
      // Start loading next item just before reaching it
      useLazyPreparation: true,
      // Customise the shuffle algorithm
      shuffleOrder: DefaultShuffleOrder(),
      // Specify the playlist items
      children: songUrls.map((url) => AudioSource.uri(Uri.parse(url))).toList(),
    );

    player.setAudioSource(playlist, initialIndex: initIndex);
  }

  void dispose() {
    player.dispose();
  }
}
