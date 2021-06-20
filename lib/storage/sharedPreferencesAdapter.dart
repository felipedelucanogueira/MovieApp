import 'dart:convert';

import 'package:movie_app/Scenes/movie.dart';
import 'package:movie_app/storage/internalStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter extends InternalStorageAdapter {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> deleteMovie(int id) async {
    final internalPref = await _prefs;
    await internalPref.remove('$id');
  }

  @override
  Future<Map<String, dynamic>> getMovieId(int id) async {
    final internalPref = await _prefs;
    final data = internalPref.getString('$id');
    return jsonDecode(data);
  }

  @override
  Future<void> saveMovie(int id, Map<String, dynamic> data) async {
    final json = jsonEncode(data);
    final internalPref = await _prefs;
    await internalPref.setString('$id', json);
  }

  @override
  Future<List<Map<String, dynamic>>> getMovieList() async {

      final internalPref = await _prefs;
      final data = internalPref.getStringList('favorites');
      final List<Map<String, dynamic>> result =
      data.map<Map<String, dynamic>>((e) => jsonDecode(e)).toList();
      return result;

  }

  @override
  Future<void> saveMovieList(List<Map<String, dynamic>> data) async {
    final List<String> json = data.map((e) => jsonEncode(e)).toList();
    final internalPref = await _prefs;
    await internalPref.setStringList('favorites', json);
  }


   saveBestMovies(int id) async {
     final internalPref = await _prefs;
     await internalPref.setInt('$id', id);
     print(id);
     print('Filme Salvo');

   }

    deleteBestMovies(int id) async {
     final internalPref = await _prefs;
      await internalPref.remove('$id');

      print(id);
     print('Filme deletado');
   }

  @override
  Future<int> getBestMovieId(int idb) async {
   final internalPref = await _prefs;
    int id = internalPref.getInt('id');

    return id;

  }

  //  Future<String> getMovieId(int id,String name) async {
  //    final internalPref = await _prefs;
  //    int identificador = internalPref.getInt('$id');
  //    String title = internalPref.getString('$name');
  //
  //    return title;
  //  }


}
