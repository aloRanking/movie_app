import 'package:movieapp/models/movie.dart';

class MovieResponse{

  final List<Movie> movies;
  final String error;

  MovieResponse(this.movies, this.error);



  MovieResponse.fromJson(Map<String,dynamic> parsedJson)
    : movies =
    (parsedJson["results"] as List).map((i) => new Movie.fromJsonMap(i)).toList(),
    error = "";


  MovieResponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;


}