import 'dart:convert';

class Movie {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  String? heroId;
  // new
  String? firebaseId;

  Movie(
      {required this.adult,
      this.backdropPath,
      required this.genreIds,
      required this.id,
      required this.originalLanguage,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      this.posterPath,
      this.releaseDate,
      required this.title,
      required this.video,
      required this.voteAverage,
      required this.voteCount,
      this.heroId,
      // new
      this.firebaseId});

  // Constructor pasándole id -1 para que se cree vacio

  Movie.empty()
      : this(
          adult: false,
          backdropPath: 'no-image',
          genreIds: [],
          id: -1,
          originalLanguage: '',
          originalTitle: '',
          overview: '',
          popularity: 0.0,
          posterPath: 'no-image',
          releaseDate: '',
          title: '',
          video: false,
          voteAverage: 0.0,
          voteCount: 0,
        );

  factory Movie.fromRawJson(String str) => Movie.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        // new
        heroId: json["id"]?.toString() ?? 'no-id',
        firebaseId: json["firebaseId"]?.toString() ?? 'no-id',
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath ?? 'no-image',
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath ?? 'no-image',
        "release_date": releaseDate ?? 'no-date',
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        // new
        "heroId": heroId ?? 'no-id',
        "firebaseId": firebaseId ?? 'no-id',
      };

  get fullPosterImg {
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get fullBackdropPath {
    if (backdropPath != null) {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}
