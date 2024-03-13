import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loremusic/song_list_screen.dart';

import 'permission.dart';

void main() async {
  // Request storage permission before running the app
  if (!await requestStoragePermission()) {
    exit(0); // Exit if permission is denied
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Optional: Consider using a provider for centralized song data management
  // final SongListProvider songListProvider = SongListProvider(); // Uncomment if using

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SongListScreen(), // Set SongListScreen as the initial route
      // Optional: Use provider for song data access in SongListScreen
      // routes: {
      //   '/': (context) => SongListScreen(),
      //   '/playback': (context) => PlaybackScreen(song: songListProvider.songs[index]), // Replace with logic to pass selected song
      // },
    );
  }
}
