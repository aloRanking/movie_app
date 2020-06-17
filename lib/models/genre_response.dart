import 'package:movieapp/models/genre.dart';

class GenreResponse{

  final List<Genre> genres;
  final String error;

  GenreResponse(this.genres, this.error);

  factory GenreResponse.fromJson(List<dynamic> parsedJson) {

    List<Genre> genres = new List<Genre>();
    String error;


    genres = parsedJson[0].map((i)=>Genre.fromJsonMap(i)).toList();
    error ='';




    return new GenreResponse(genres, error);
  }

  GenreResponse.withError(String errorValue)
      : genres = List(),
        error = errorValue;


}