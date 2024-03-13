import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.PartidoProgressBar.with_Haptics.dart'; // Import specific class for haptics

import 'song.dart';

class PlaybackScreen extends StatefulWidget {
  final Song song;

  const PlaybackScreen({required this.song});

  @override
  _PlaybackScreenState createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen> {
  final player = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
    player.dispose(); // Release resources when done
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
      ),
      body: Column(
        children: [
          Center(
            child: widget.song.albumArt != null
                ? Image.network(widget.song.albumArt)
                : const Icon(CupertinoIcons.music_note), // Placeholder for missing album art
          ),
          Text(widget.song.artist),
          Text(widget.song.album), // Assuming album information is available
          StreamBuilder<Duration>(
            stream: player.positionStream,
            builder: (context, snapshot) {
              final position = snapshot.data ?? Duration.zero;
              return PartidosProgressBar(
                player: player,
                progress: position,
                total: player.duration,
                onSeekToStart: () => player.seek(Duration.zero),
                onSeekToEnd: () => player.seek(player.duration!),
                onPaused: player.pause,
                onPlaying: player.play,
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(player.playing ? CupertinoIcons.pause : CupertinoIcons.play_arrow),
                onPressed: () => player.playing ? player.pause() : player.play(),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.wind),
                onPressed: () => player.seek(player.position - const Duration(seconds: 10)),
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.forward),
                onPressed: () => player.seek(player.position + const Duration(seconds: 10)),
              ),
            ],
          ),
          Slider(
            value: player.volume,
            min: 0.0,
            max: 1.0,
            onChanged: (value) => player.setVolume(value),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.audiotrack),
        onPressed: () async {
          // Handle potential errors during playback initialization (optional)
          try {
            await player.setAudioSource(AudioSource.uri(widget.song.filePath as Uri));
            await player.play();
          } on PlayerException catch (e) {
            // Display user-friendly error message
            print('Error playing song: $e');
          }
        },
      ),
    );
  }
}
