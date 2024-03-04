import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';

class CustomAppBar extends StatelessWidget {
  final Movie movie;

  const CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.indigo,
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          titlePadding: EdgeInsets.zero,
          title: Container(
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            width: double.infinity,
            child: Text(movie.title, style: const TextStyle(fontSize: 16)),
          ),
          background: FadeInImage(
              placeholder: const AssetImage('assets/images/loading.gif'),
              image: NetworkImage(movie.fullBackdropPath),
              fit: BoxFit.cover),
        ));
  }
}
