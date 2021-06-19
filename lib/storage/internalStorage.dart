abstract class InternalStorageAdapter{
     Future<void> saveMovie(int id, Map<String, dynamic> data);
     Future<void>  saveMovieList(List<Map<String, dynamic>>data);
     Future<void> deleteMovie(int id);
     Future<Map<String,dynamic>> getMovieId(int id);
     Future<List<Map<String, dynamic>>> getMovieList();


}