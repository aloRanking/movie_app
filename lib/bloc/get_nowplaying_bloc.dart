import 'package:movieapp/models/movie_response.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayingListBloc{
  final MovieRepository _repository = MovieRepository();

  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getNowPlayingList() async {
    MovieResponse response = await _repository.getNowPlayingMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;

}
final nowPlayingBloc = NowPlayingListBloc();
