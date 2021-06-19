import 'dart:convert';

import 'package:movie_app/storage/internalStorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter extends InternalStorageAdapter {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> deleteMovie(int id)async {
    final internalPref = await _prefs;
        await internalPref.remove('$id');
       print('Filme deletado');

  }

  @override
  Future<Map<String, dynamic>> getMovieId(int id) async{
    try{
      final internalPref = await _prefs;
      final data = internalPref.getString('$id');
      print(id);
      print(data);
      return jsonDecode(data);

    }catch(e){

      print(e);
      return null;
    }


  }


  @override
  Future<void> saveMovie(int id, Map<String, dynamic> data)async {

       try{
         print(data);
         final json = jsonEncode(data);
         print(json);
         final internalPref = await _prefs;
         await internalPref.setString('$id', json);
         print('filme salvo');
       }catch(e){
         print(e);
       }

  }

  @override
  Future<List<Map<String, dynamic>>> getMovieList() async {
    try{
      final internalPref = await _prefs;
      final data = internalPref.getStringList('favorites');
      final List<Map<String,dynamic>> result = data.map<Map<String, dynamic>>((e) => jsonDecode(e)).toList();
      return result;

    }catch(e){
      print(e);
      return null;
    }
  }

  @override
  Future<void> saveMovieList(List<Map<String, dynamic>> data) async{
    try{
      print(data);
      final List<String>json = data.map((e) => jsonEncode(e)).toList();
      final internalPref = await _prefs;
      await internalPref.setStringList('favorites', json);
      print(json);
    }catch(e){
      print(e);
    }
  }

 // Future<void> saveMovie(int id, String name) async {
 //    final internalPref = await _prefs;
 //    await internalPref.setInt('$id', id);
 //    await internalPref.setString('$name', name);
 //
 //    print('Filme Salvo');
 //  }
 //
 //  Future <void> deleteMovie(int id, String name) async {
 //    final internalPref = await _prefs;
 //
 //     await internalPref.remove('$id');
 //      await internalPref.remove('$name');
 //
 //    print('Filme deletado');
 //  }
 //
 //  Future<String> getMovieId(int id,String name) async {
 //    final internalPref = await _prefs;
 //    int identificador = internalPref.getInt('$id');
 //    String title = internalPref.getString('$name');
 //
 //    return title;
 //  }






}
