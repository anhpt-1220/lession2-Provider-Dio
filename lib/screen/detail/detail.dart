import 'package:cached_network_image/cached_network_image.dart';
import 'package:example_moviedb/model/movie_detail_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen(this.id, {Key? key}) : super(key: key);

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  int get movieId => widget.id;
  late MovieDetailViewModel _provider;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _provider = Provider.of<MovieDetailViewModel>(context, listen: false);
      _provider.getMovieDetail(movieId);
    });
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () async {
      _provider.clear();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Movie details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(child:
          Consumer<MovieDetailViewModel>(builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 4, right: 4),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      imageUrl: getImageUrl(viewModel.movieDetail?.posterPath),
                      placeholder: (context, url) => Image.asset(
                        'assets/images/place_holder.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/place_holder.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: ClipPath(
                      clipper: CustomTriangleClipper(),
                      child: Container(
                        color: Colors.white,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: CachedNetworkImage(
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover,
                      imageUrl: getImageUrl(viewModel.movieDetail?.posterPath),
                      placeholder: (context, url) => Image.asset(
                        'assets/images/place_holder.png',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/place_holder.png',
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      viewModel.movieDetail?.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    CircularPercentIndicator(
                      radius: 20.0,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 5,
                      percent: (viewModel.movieDetail?.voteAverage ?? 0) / 10,
                      center: Text(
                        '${viewModel.movieDetail?.voteAverage ?? ''}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.black,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/chat.png',
                              height: 30,
                              width: 30,
                            ),
                            const Text('Reviews',
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 1.5,
                      color: Colors.transparent,
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/play.png',
                              height: 30,
                              width: 30,
                            ),
                            const Text('Trailers',
                                style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Gernes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            viewModel.movieDetail?.genres.first.name ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            'Release',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            viewModel.movieDetail?.releaseDate ?? '',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.only(
                    top: 7, left: 15, right: 15, bottom: 15),
                child: Text(
                  viewModel.movieDetail?.overview ?? '',
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        );
      })),
    );
  }

  String getImageUrl(String? path) {
    return path != null ? 'https://image.tmdb.org/t/p/w500/$path' : "";
  }
}

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
