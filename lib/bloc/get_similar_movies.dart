import 'package:movieapp/models/movie_response.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class SimilarMoviesBloc{
  final MovieRepository _repository = MovieRepository();

  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getSimilarMovies(int id) async {
    MovieResponse response = await _repository.getSimilarMovies(id);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}
final similarMoviesBloc = SimilarMoviesBloc();
