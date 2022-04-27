import 'package:example_moviedb/model/movie.dart';
import 'package:example_moviedb/movie_service.dart';
import 'package:flutter/foundation.dart';

import 'movie_response.dart';

enum LoadingStatus { finish, loading}

class MovieViewModel with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.finish;
  final List<Movie> _moviesList = [];
  int currentPage = 1;
  int totalPage = 1;

  Future<void> getMoviesList({int page = 1, bool isRefresh = false}) async {
    if (page == 1 && !isRefresh) {
      loadingStatus = LoadingStatus.loading;
      notifyListeners();
    }
    MovieResponse movieResponse = await MovieService().getMovies(page);
    if (isRefresh) {
      _moviesList.clear();
    }
    _moviesList.addAll(movieResponse.movies);
    loadingStatus = LoadingStatus.finish;
    currentPage = movieResponse.page;
    totalPage = movieResponse.totalPage;
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    if (!haveLoadMore()) {
      return;
    }
    await getMoviesList(page: ++currentPage);
  }

  int getSize() {
    int length = _moviesList.length;
    if (haveLoadMore()) {
      length++;
    }
    return length;
  }

  bool haveLoadMore() {
    return currentPage < totalPage;
  }

  List<Movie> get moviesList => _moviesList;
}
