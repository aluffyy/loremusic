class Song {
  final String title;
  final String artist;
  final String album;
  final String filePath;
  final String? albumArt; // Optional album art URL (can be null)

  Song({
    required this.title,
    required this.artist,
    required this.album,
    required this.filePath,
    this.albumArt,
  });
}
