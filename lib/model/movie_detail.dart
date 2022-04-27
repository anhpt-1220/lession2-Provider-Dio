class MovieDetail {
  int id;
  String title;
  String overview;
  String? posterPath;
  String? backdropPath;
  int voteCount;
  double voteAverage;
  String releaseDate;
  List<Genres> genres;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteCount,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
  });

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
      voteCount: map['vote_count'] ?? 0,
      voteAverage: map['vote_average'] ?? 0,
      releaseDate: map['release_date'] ?? '',
      genres: List<Genres>.from(map["genres"].map((x) => Genres.fromMap(x))),
    );
  }
}

class Genres {
  Genres({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genres.fromMap(Map<String, dynamic> json) => Genres(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
}
