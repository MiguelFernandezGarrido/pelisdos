import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class Favourites extends StatelessWidget {
  static const String routeName = 'favourites';
  const Favourites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MoviesProvider provider = Provider.of<MoviesProvider>(context);
    List<Movie> movies = provider.favourites;

    if (movies.isEmpty) {
      return const Center(
        child: Text('No hay películas'),
      );
    }

    return Center(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5.0),
            child: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 87, 30, 193)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  title: Text(movie.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  leading: Image.network(movie.fullPosterImg ?? ''),
                  trailing: IconButton(
                    onPressed: () {
                      provider.changeFavourite(movie);
                    },
                    icon: Icon(
                      movie.firebaseId != null && movie.firebaseId != 'no-id'
                          ? Icons.favorite
                          : Icons.favorite_outline_rounded,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
