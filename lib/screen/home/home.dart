import 'package:example_moviedb/model/movie_notifiers.dart';
import 'package:example_moviedb/screen/home/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      Provider.of<MovieViewModel>(context, listen: false).getMoviesList();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Provider.of<MovieViewModel>(context, listen: false).loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Align(
          child: Text(
            "Popular",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Consumer<MovieViewModel>(builder: (context, viewModel, child) {
        return _buildList(viewModel);
      })),
    );
  }

  Widget _buildList(MovieViewModel movieViewModel) {
    return RefreshIndicator(
      onRefresh: () async {
        return movieViewModel.getMoviesList(isRefresh: true);
      },
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: movieViewModel.getSize(),
                  itemBuilder: (context, index) {
                    if (movieViewModel.moviesList.length == index) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return MovieItem(movie: movieViewModel.moviesList[index]);
                    }
                  },
                ),
              ),
            ],
          ),
          if (movieViewModel.loadingStatus == LoadingStatus.loading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
