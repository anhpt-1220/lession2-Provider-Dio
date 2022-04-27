import 'package:dio/dio.dart';
import 'package:example_moviedb/model/movie_detail.dart';

import 'model/movie_response.dart';

const apiKey = "81220b3dccf20362c5451ee74639e4ea";

class MovieService {
  final _dio = Dio();


  Future<MovieResponse> getMovies(int page) async {
    try {
      final response = await _dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=en-US&page=$page',
      );
      final results = Map<String, dynamic>.from(response.data);
      MovieResponse movieResponse = MovieResponse.fromMap(results);
      return movieResponse;
    } on DioError catch (dioError) {
      throw '$dioError';
    }
  }

  Future<MovieDetail> getDetailMovie(int id) async {
    try {
      final response = await _dio
          .get('https://api.themoviedb.org/3/movie/$id?api_key=$apiKey');
      MovieDetail detail = MovieDetail.fromMap(response.data);
      return detail;
    } on DioError catch (dioError) {
      throw '$dioError';
    }
  }
}