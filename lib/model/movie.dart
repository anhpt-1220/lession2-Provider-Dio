import 'dart:convert';

class Movie {
  int id = 0;
  String title;
  String? posterPath;
  String overview;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      posterPath: map['poster_path'],
      overview: map['overview'] ?? '',
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
