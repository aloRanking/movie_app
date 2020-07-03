

import 'package:dio/dio.dart';
import 'package:movieapp/models/cast_response.dart';
import 'package:movieapp/models/genre_response.dart';
import 'package:movieapp/models/movie_detail_response.dart';
import 'package:movieapp/models/movie_response.dart';

class MovieRepository{
  final String _apiKey = '';
  static String _baseUrl = 'https://api.themoviedb.org/3';

  final Dio _dio = Dio();

  String getNowPlayingUrl = '$_baseUrl/movie/now_playing';
  String getGenreIds = '$_baseUrl/genre/movie/list';
  String getMoviesUrl = '$_baseUrl/discover/movie';
  String getPopularUrl = '$_baseUrl/movie/popular';
  String getTopRatedUrl = '$_baseUrl/movie/top_rated';
  String getUpcomingUrl = '$_baseUrl/movie/upcoming';
  String movieUrl = "$_baseUrl/movie";


  Future<MovieResponse> getNowPlayingMovies() async{
    var params = {
      "api_key" : _apiKey,
      "languae" : "en-US",
      "page": 1
    };

    try{
      Response response = await _dio.get(getNowPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPopularMovies() async{
    var params = {
      "api_key" : _apiKey,
      "languae" : "en-US",
      "page": 1
    };

    try{
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getTopRatedMovies() async{
    var params = {
      "api_key" : _apiKey,
      "languae" : "en-US",
      "page": 1
    };

    try{
      Response response = await _dio.get(getTopRatedUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getUpcomingMovies() async{
    var params = {
      "api_key" : _apiKey,
      "languae" : "en-US",
      "page": 1
    };

    try{
      Response response = await _dio.get(getUpcomingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenre() async{
    var params = {
      "api_key" : _apiKey,
      "languae" : "en-US"
    };

    try{
      Response response = await _dio.get(getGenreIds, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {"api_key": _apiKey, "language": "en-US", "page": 1, "with_genres": id};
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      "api_key": _apiKey,
      "language": "en-US"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {
      "api_key": _apiKey,
      "language": "en-US"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

 /* Future<VideoResponse> getMovieVideos(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }*/



  Future<CastResponse> getCasts(int id) async {
    var params = {
      "api_key": _apiKey,
      "language": "en-US"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/credits", queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastResponse.withError("$error");
    }
  }
}


