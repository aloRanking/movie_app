
class Movie {

  final int id;
  final String title;
  final String poster_path;
  final String overview;
  final String release_date;
  final String original_title;
  final String backdrop_path;
  final double vote_average;

	Movie.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		title = map["title"],
		poster_path = map["poster_path"],
		overview = map["overview"],
		release_date = map["release_date"],
		//genre_ids = List<int>.from(map["genre_ids"]),
		original_title = map["original_title"],
		backdrop_path = map["backdrop_path"],
		vote_average = map["vote_average"].toDouble();

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['title'] = title;
		data['poster_path'] = poster_path;
		data['overview'] = overview;
		data['release_date'] = release_date;
		//data['genre_ids'] = genre_ids;
		data['original_title'] = original_title;
		data['backdrop_path'] = backdrop_path;
		data['vote_average'] = vote_average;
		return data;
	}
}
