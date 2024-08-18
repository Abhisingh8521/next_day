import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseServices {
  static final LocalDatabaseServices instance = LocalDatabaseServices._init();
  static Database? _database;

  LocalDatabaseServices._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("user.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE page (
      id INTEGER PRIMARY KEY,
      pageId TEXT UNIQUE
    )
    ''');
  }

  Future<void> addFavoriteUsers(String pageId) async {
    final db = await instance.database;
    await db.insert("page", {"pageId": pageId},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> deleteFavoriteUsers(String pageId) async {
    final db = await instance.database;
    await db.delete("page", where: "pageId = ?", whereArgs: [pageId]);
  }

  Future<List<String>> getFavoriteUsers() async {
    final db = await instance.database;
    final result = await db.query("page", columns: ["pageId"]);
    return result.map((e) => e["pageId"] as String).toList();
  }
}
