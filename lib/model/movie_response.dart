import 'dart:convert';
import 'package:example_moviedb/model/movie.dart';

class MovieResponse {
  int page;
  int totalPage;
  List<Movie> movies;

  MovieResponse(
      {required this.page, required this.totalPage, required this.movies});

  factory MovieResponse.fromMap(Map<String, dynamic> map) {
    return MovieResponse(
      page: map['page'] ?? 0,
      movies: List<Movie>.from(map["results"].map((x) => Movie.fromMap(x))),
      totalPage: map['total_pages'] ?? 0,
    );
  }

  factory MovieResponse.fromJson(String source) =>
      MovieResponse.fromMap(json.decode(source));
}
