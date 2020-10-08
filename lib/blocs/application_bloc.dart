import 'dart:async';
import 'dart:collection';

import '../api/tmdb_api.dart';
import '../blocs/bloc_provider.dart';
import '../models/movie_genre.dart';
import '../models/movie_genres_list.dart';

class ApplicationBloc implements BlocBase {

  ///
  /// Synchronous Stream to handle the provision of the movie genres
  ///
  StreamController<List<MovieGenre>> _syncController = StreamController<List<MovieGenre>>.broadcast();
  Stream<List<MovieGenre>> get outMovieGenres => _syncController.stream;

  /// 
  StreamController<List<MovieGenre>> _cmdController = StreamController<List<MovieGenre>>.broadcast();
  StreamSink get getMovieGenres => _cmdController.sink;




  ApplicationBloc() {
    // Read all genres from Internet
    api.movieGenres().then((list) {
      _genresList = list;
    });

    _cmdController.stream.listen((_){
      _syncController.sink.add(UnmodifiableListView<MovieGenre>(_genresList.genres));
    });
  }

  void dispose(){
    _syncController.close();
    _cmdController.close();
  }

  MovieGenresList _genresList;
   
}
