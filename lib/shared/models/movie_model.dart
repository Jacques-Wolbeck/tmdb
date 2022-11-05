import 'package:tmdb/shared/models/genre_model.dart';

class MovieModel {
  int id;
  String originalTitle;
  String? poster;
  List<int> genreIds;
  List<GenreModel> genres;
  String? overview;
  DateTime releaseDate;
  String originalLanguage;

  MovieModel({
    required this.id,
    required this.originalTitle,
    this.poster,
    required this.genreIds,
    required this.genres,
    this.overview,
    required this.releaseDate,
    required this.originalLanguage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> movie) {
    return MovieModel(
      id: movie['id'],
      originalTitle: movie['original_title'],
      poster: movie['poster_path'],
      genreIds: List<int>.from(movie['genre_ids'].map((value) => value)),
      genres: List.empty(growable: true),
      overview: movie['overview'],
      releaseDate: DateTime.parse(movie['release_date']),
      originalLanguage: movie['original_language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'original_title': originalTitle,
      'poster_path': poster,
      'genre_ids': genreIds,
      'genres': genres,
      'overview': overview,
      'release_date': releaseDate,
      'original_language': originalLanguage
    };
  }
}
