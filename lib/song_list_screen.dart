import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'playback_screen.dart';
import 'song.dart'; // Import the Song class

class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  // Your song data management method (provider or other logic)
  late final List<Song> songs;

  @override
  void initState() {
    super.initState();
    // Fetch song data using your chosen method
    fetchSongs();
  }

  void fetchSongs() async {
    // Replace with your actual song data fetching logic
    final fetchedSongs = await loadSongsFromSource(); // Example placeholder
    setState(() {
      songs = fetchedSongs;
    });
  }

  // Example placeholder for song data retrieval
  Future<List<Song>> loadSongsFromSource() async {
    // Simulate loading songs from a source
    await Future.delayed(Duration(seconds: 2));
    return [
      // Add your parsed song data here
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: songs.isEmpty
          ? Center(child: SpinKitFadingCircle(color: Colors.blue))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust for desired number of columns
        ),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return SongListItem(song: song);
        },
      ),
    );
  }
}

class SongListItem extends StatelessWidget {
  final Song song;

  const SongListItem({required this.song});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaybackScreen(song: song),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (song.albumArt != null) // Only display if albumArt exists
                Image.network(song.albumArt),
              Text(
                song.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(song.artist),
                  Text(song.album),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


