import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'song.dart';

class SongListProvider extends ChangeNotifier {
  List<Song> songs = [];

  Future<void> loadSongs() async {
    // Request storage permission
    if (await Permission.storage.request().isGranted) {
      // Access device storage
      Directory? musicDirectory = await getExternalStorageDirectory();
      if (musicDirectory != null) {
        List<FileSystemEntity> files = await musicDirectory.list().toList();
        List<Song> parsedSongs = files
            .where((entity) => entity.path.endsWith('.mp3'))
            .map((file) => Song(
          // Assuming title, artist, album, and filePath can be extracted from file path
          title: getFileTitleFromPath(file.path),
          artist: getFileArtistFromPath(file.path),
          album: getFileAlbumFromPath(file.path),
          filePath: file.path,
        ))
            .toList();
        songs = parsedSongs;
      }
    } else {
      // Handle permission denied
      print('Storage permission denied');
    }
    notifyListeners();
  }

  // Implement logic to extract song information from file path (placeholder examples)
  String getFileTitleFromPath(String path) {
    // Example logic, adjust as needed
    return path.split('/').last.split('.').first;
  }

  String getFileArtistFromPath(String path) {
    // Extract artist information (adjust as needed)
    return 'Unknown Artist';
  }

  String getFileAlbumFromPath(String path) {
    // Extract album information (adjust as needed)
    return 'Unknown Album';
  }
}
