import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLAdapter {

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDb();
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'favorites_movie_database.db');
    return await openDatabase(path, onCreate: (db, version) {
      return db.execute('CREATE TABLE Favorites(id TEXT PRIMARY KEY)');
    }, version: 1);
  }

  void saveMovie() async{
    final Database db = await database;
    var movie;
    await db.insert('Favorites', movie);
  }
}
