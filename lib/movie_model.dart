import 'package:movie_app/api.dart';
import 'movie.dart';

class MovieModel{

  Future<Movie> _movie;
  Future<Movie> get movie =>_movie;

  Future<TopRatedMovie> _ratedMovie;
  Future<TopRatedMovie> get ratedMovie => _ratedMovie;

  fetchMovie(){
    _movie = API().fetchMovie();


  }
  fetchRatedMovie(){
    _ratedMovie = API().fetchRatedMovie();


  }

}