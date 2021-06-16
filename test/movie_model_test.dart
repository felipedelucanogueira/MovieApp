import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/Scenes/movie.dart';
import 'package:movie_app/model/movie_model.dart';


void main(){

  test('fetchMovie should return a movie',(){
    final model = MovieModel(api: MockApi());

    model.fetchMovie();

    expect(model.movie, completion(isNotNull));

    model.movie.then((movie) {
      expect(movie.movies[0].title, 'Blair Witch');


    });
  });
}


class MockApi extends API {
 @override
 Future<Movie> fetchMovie(){
   final movie = Movie(movies: [MovieList(title: 'Blair Witch',vote_average: 10)]);
   return Future.value(movie);
  }
}