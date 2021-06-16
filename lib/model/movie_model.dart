import 'package:movie_app/api/api.dart';
import '../Scenes/movie.dart';

class MovieModel {

  int page = 1;
  int ratedPage = 1;

  Future<Movie> _movie;
  Future<Movie> get movie => _movie;

  Future<TopRatedMovie> _ratedMovie;
  Future<TopRatedMovie> get ratedMovie => _ratedMovie;

  final API api;

  MovieModel({this.api = const API()});

  fetchMovie() {
    _movie = api.fetchMovie(page: page);

  }

  fetchRatedMovie() {
    _ratedMovie = api.fetchRatedMovie(ratedPage: ratedPage);
  }
}
