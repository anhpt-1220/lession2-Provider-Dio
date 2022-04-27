import 'package:cached_network_image/cached_network_image.dart';
import 'package:example_moviedb/screen/detail/detail.dart';
import 'package:flutter/material.dart';

import '../../model/movie.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen(movie.id)),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  height: 150,
                  width: 100,
                  fit: BoxFit.cover,
                  imageUrl: getImageUrl(movie.posterPath),
                  placeholder: (context, url) => Image.asset(
                    'assets/images/place_holder.png',
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 20),
                        child: Text(
                          movie.title,
                          style: const TextStyle(fontSize: 22),
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        movie.overview,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getImageUrl(String? path) {
    return path != null ? 'https://image.tmdb.org/t/p/w500/$path' : "";
  }
}
