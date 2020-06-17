import 'package:movieapp/models/genre_response.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class GenreListBloc{
  final MovieRepository _repository = MovieRepository();

  final BehaviorSubject<GenreResponse> _subject =
  BehaviorSubject<GenreResponse>();

  getGenreList() async {
    GenreResponse response = await _repository.getGenre();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;

}
final genreBloc = GenreListBloc();
