import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cast.dart';
import '../providers/movies_provider.dart';

// ignore: must_be_immutable
class CastingCards extends StatelessWidget {
  final int movieId;
  ScrollController scrollController = ScrollController();
  CastingCards({super.key, required this.movieId});

  // método dispose
  void dispose() {
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 180,
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Container(
                margin: const EdgeInsets.only(bottom: 30),
                height: 180,
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 5,
                  controller: scrollController,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, int index) =>
                        _CastCard(snapshot.data![index]),
                  ),
                ));
          }
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'actor_detail', arguments: actor);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                placeholder: const AssetImage('assets/images/no-image.jpg'),
                image: NetworkImage(actor.profileImg),
                height: 140,
                width: 100,
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          actor.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
