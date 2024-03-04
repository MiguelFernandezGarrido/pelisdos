// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieSlider extends StatefulWidget {
  List<Movie> movies;
  String title;
  Function nextPage;
  String? numSlider;
  MovieSlider(
      {super.key,
      required this.movies,
      required this.title,
      required this.nextPage,
      required this.numSlider});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        widget.nextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 212, // Ajusta la altura de acuerdo a tus necesidades
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              trackVisibility: true,
              thickness: 5,
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.movies.asMap().entries.map((entry) {
                    final index = entry.key;
                    final movie = entry.value;
                    return _MoviePoster(
                      index,
                      movie: movie,
                      numSlider: widget.numSlider,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  int? pos;
  String? numSlider;
  Movie movie;
  _MoviePoster(this.pos, {required this.movie, required this.numSlider});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'slider-${movie.id}-$pos-$numSlider';
    return Container(
      width: 130,
      height: 212,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'detail', arguments: movie),
          child: Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/images/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 175,
                  fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center)
      ]),
    );
  }
}
