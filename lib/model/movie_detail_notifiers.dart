import 'package:example_moviedb/model/movie_detail.dart';
import 'package:example_moviedb/movie_service.dart';
import 'package:flutter/foundation.dart';

enum LoadingStatus { finish, loading }

class MovieDetailViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.finish;
  MovieDetail? _movieDetail;

  Future<void> getMovieDetail(int id) async {
    loadingStatus = LoadingStatus.loading;
    notifyListeners();
    _movieDetail = await MovieService().getDetailMovie(id);
    loadingStatus = LoadingStatus.finish;
    notifyListeners();
  }

  void clear() {
    _movieDetail = null;
    notifyListeners();
  }

  MovieDetail? get movieDetail => _movieDetail;
}
