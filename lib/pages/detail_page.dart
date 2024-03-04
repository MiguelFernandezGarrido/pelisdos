// import 'package:appinio_video_player/appinio_video_player.dart';
// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:peliculas/service/video_service.dart';
import 'package:peliculas/widgets/custom_appbar.dart';

import '../models/movie.dart';
import '../widgets/casting_cards.dart';
import '../widgets/overview.dart';
import '../widgets/poster_and_title.dart';
import '../widgets/video_player.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    VideoService videoService = VideoService();
    Future<String> videoUrl = videoService.getVideoId(movie.id);

    return FutureBuilder(
      future: videoUrl,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(movie.title),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
              appBar: AppBar(
                title: Text(movie.title),
              ),
              body: const Center(
                child: Text('Error al cargar la información'),
              ));
        }
        return Scaffold(
          body: CustomScrollView(slivers: [
            CustomAppBar(
              movie: movie,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              PosterAndTitle(
                movie: movie,
              ),
              Overview(
                movie: movie,
              ),
              CastingCards(movieId: movie.id),
              VideoPlayer(
                urlVideo: videoUrl,
              ),
            ]))
          ]),
        );
      },
    );
  }
}
