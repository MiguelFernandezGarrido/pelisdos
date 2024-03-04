import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:provider/provider.dart';
import 'package:peliculas/providers/movies_provider.dart';

class PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const PosterAndTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    MoviesProvider provider = Provider.of<MoviesProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height: 200,
                  placeholder: const AssetImage('assets/images/no-image'),
                  image: NetworkImage(movie.fullPosterImg),
                )),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              provider.changeFavourite(movie);
            },
            icon: movie.firebaseId != null &&
                    movie.firebaseId!.isNotEmpty &&
                    movie.firebaseId != 'no-id'
                ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite_outline, color: Colors.red),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 300),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                movie.originalTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: double.infinity,
                child: Row(children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ]),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
