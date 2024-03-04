import 'dart:convert';

import 'package:peliculas/models/movie.dart';

class UpcomingResponse {
  Dates dates;
  int page;
  List<Movie> movies;
  int totalPages;
  int totalResults;

  UpcomingResponse({
    required this.dates,
    required this.page,
    required this.movies,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingResponse.fromRawJson(String str) =>
      UpcomingResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingResponse.fromJson(Map<String, dynamic> json) =>
      UpcomingResponse(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        movies: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates.toJson(),
        "page": page,
        "results": List<dynamic>.from(movies.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}
