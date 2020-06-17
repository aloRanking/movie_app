import 'package:movieapp/models/movie_response.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class PopularMoviesListBloc{
  final MovieRepository _repository = MovieRepository();

  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getPopularMoviesList() async {
    MovieResponse response = await _repository.getPopularMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}
final popularMoviesBloc = PopularMoviesListBloc();
