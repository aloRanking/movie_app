import 'genre.dart';

class MovieDetail{

  final int id;
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final String releaseDate;
  final int runtime;
  final String overview;




  MovieDetail.fromJson(Map<String, dynamic> json)
      : id = json["id"],
  adult = json["adult"],
  budget = json["budget"],
  genres = (json["genres"] as List).map((i) => new Genre.fromJsonMap(i)).toList(),
  releaseDate = json["release_date"],
  runtime = json["runtime"],
  overview = json["overview"];


}