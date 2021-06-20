import 'package:movie_app/api/api.dart';
import 'package:movie_app/storage/internalStorage.dart';
import 'package:movie_app/storage/sharedPreferencesAdapter.dart';
import '../Scenes/movie.dart';

class MovieModel {
  final InternalStorageAdapter internalStorage = SharedPreferencesAdapter();

  int page = 1;
  int ratedPage = 1;

  Future<Movie> _movie;
  Future<Movie> get movie => _movie;

  Future<TopRatedMovie> _ratedMovie;
  Future<TopRatedMovie> get ratedMovie => _ratedMovie;

  final API api;

  MovieModel({this.api = const API()});

  saveMovie(int id, MovieList saveMovie) {
    internalStorage.saveMovie(id, saveMovie.toMap());
  }

  saveBestMovies(int idb) async{
      await internalStorage.saveBestMovies(idb);
  }
    deleteBestMovies(int idb) async{
        await internalStorage.deleteMovie(idb);
    }

  //
  // saveFavorite(List<Map<String, dynamic>> data) async{
  //   await internalStorage.saveMovieList(data);
  //
  // }

  // Future<String> getMovieList() async{
  //    final movieData = await internalStorage.getMovieList();
  //    return ' ';
  //
  //  }

  Future<String> getMovieId(int id) async {
    final movieData = await internalStorage.getMovieId(id);
    final MovieList movieResult = MovieList.fromJson(movieData);
    return movieResult.title;
  }

  Future<int> getBestMovieId(int id) async {
     final idb = await internalStorage.getBestMovieId(id);

     return idb;
  }

  deleteMovie(int id) async {
    await internalStorage.deleteMovie(id);
  }

  fetchMovie() {
    _movie = api.fetchMovie(page: page);
  }

  fetchRatedMovie() {
    _ratedMovie = api.fetchRatedMovie(ratedPage: ratedPage);
  }
}
