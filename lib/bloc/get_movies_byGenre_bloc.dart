import 'package:flutter/cupertino.dart';
import 'package:movieapp/models/movie_response.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGenreBloc{
  final MovieRepository _repository = MovieRepository();

  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getMoviesByGenreList(int id) async {
    MovieResponse response = await _repository.getMovieByGenre(id);
    _subject.sink.add(response);
  }

  void drainStream(){_subject.value = null;}
  @mustCallSuper
  dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}
final movieslistBloc  = MoviesListByGenreBloc();
