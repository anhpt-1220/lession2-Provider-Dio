import 'package:example_moviedb/model/movie_notifiers.dart';
import 'package:example_moviedb/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/movie_detail_notifiers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MovieViewModel>(
              create: (_) => MovieViewModel()),
          ChangeNotifierProvider<MovieDetailViewModel>(
              create: (_) => MovieDetailViewModel()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(backgroundColor: Colors.white),
          home: const HomeScreen(),
        ));
  }
}
