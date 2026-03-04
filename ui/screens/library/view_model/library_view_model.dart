import 'package:flutter/material.dart';

import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository _songRepository;
  final PlayerState _playerState;

  // 3 Expose all UI data through getters

  List<Song> _songs = [];
  List<Song> get songs => _songs;

  Song? get currentSong => _playerState.currentSong;
  bool isPlaying(Song song) => _playerState.currentSong == song;

  LibraryViewModel({
    required SongRepository songRepository,
    required PlayerState playerState,
  }) : _songRepository = songRepository,
       _playerState = playerState {
    init();
  }

  //1 create init() to fetch songs from the repository

  void init() {
    _songs = _songRepository.fetchSongs();
    notifyListeners();
  }

  // 2 listen to playerstate and cal notifyListeners() on chnage
  @override
  void addListener(VoidCallback listener) {
    _playerState.addListener(notifyListeners);
    super.addListener(listener);
  }



  // 4 expose user actions
  void playSong(Song song) {
    _playerState.start(song);
  }

  void stopSong() {
    _playerState.stop();
  }

  @override
  void dispose() {
    _playerState.removeListener(notifyListeners);
    super.dispose();
  }
}
