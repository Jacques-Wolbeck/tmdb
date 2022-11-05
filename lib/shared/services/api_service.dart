import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb/shared/models/genre_model.dart';
import 'package:tmdb/shared/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService instance = ApiService._init();
  ApiService._init();

  static const apiKey = 'f321a808e68611f41312aa8408531476';

  Future<List<MovieModel>> getAllMovies(int page) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&page=${page.toString()}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        var moviesList = List<MovieModel>.from(
          jsonResponse['results'].map(
            (value) => MovieModel.fromJson(value),
          ),
        );
        var genresList = await getAllGenres();
        for (var movie in moviesList) {
          for (var id in movie.genreIds) {
            for (var element in genresList) {
              if (element.id == id) {
                movie.genres.add(element);
              }
            }
          }
        }
        return moviesList;
      }
      return [];
      /*List<MovieModel> movies = jsonResponse['results']
          .map((element) => MovieModel.fromJson(element)).;
      return movies;*/
    } on PlatformException catch (error) {
      debugPrint("--> ${error.toString()}");
      return [];
    }
  }

  Future<List<GenreModel>> getAllGenres() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey&page=10');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return List<GenreModel>.from(
          jsonResponse['genres'].map(
            (value) => GenreModel.fromJson(value),
          ),
        );
      }
      return [];
    } on PlatformException catch (error) {
      debugPrint("--> ${error.toString()}");
      return [];
    }
  }
}
