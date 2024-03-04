import 'dart:convert';

import 'movie.dart';

class TopRatedResponse {
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  TopRatedResponse({
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory TopRatedResponse.fromRawJson(String str) =>
      TopRatedResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TopRatedResponse.fromJson(Map<String, dynamic> json) =>
      TopRatedResponse(
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
