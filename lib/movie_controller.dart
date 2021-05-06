import 'package:movie_app/api.dart';
import 'package:movie_app/movie_model.dart';
import 'movie.dart';

class MovieController {
  final model = MovieModel();
  final api = API();

  Future<Movie> get movie => model.movie;


  Future<TopRatedMovie> get ratedMovie => model.ratedMovie;

  loadMovie() {
    model.fetchMovie();

  }
  loadRatedMovie(){
    model.fetchRatedMovie();
  }


}
