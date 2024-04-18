import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDbUtils {
  static Database? _db;

  static const _databaseName = 'teknosoft.db';
  static const _databaseVersion = 1;

  static const table = 'tasks';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnStartDate = 'startDate';
  static const columnEndDate = 'endDate';
  static const columnPriority = 'priority';
  static const columnCategory = 'category';
  static const columnImportant = 'important';
  static const columnCompleted = 'completed';

  //!للتأكد إذا كانت موجودة القاعدة فإن لم تكن موجودة تنشئها
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  //!لإنشاء قاعدة البيانات
  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, _databaseName);
    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: _databaseVersion,
      onUpgrade: _onUpgrade,
    );
    return mydb;
  }

  //!لحذف قاعدة البيانات
  myDeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "teknosoft.db");
    await deleteDatabase(path);
  }

  //!تابع الإنشاء
  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
        CREATE TABLE "${table}"(
          "$columnId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          "$columnTitle" TEXT NOT NULL,
          "$columnStartDate" TEXT NOT NULL,
          "$columnEndDate" TEXT NOT NULL,
          "$columnPriority" INTEGER NOT NULL,
          "$columnCategory" INTEGER NOT NULL,
          "$columnImportant" INTEGER NOT NULL DEFAULT 0,
          "$columnCompleted" INTEGER NOT NULL DEFAULT 0
        )
      ''');

    // batch.execute("ALTER TABLE notes ADD COLUMN color TEXT");

    batch.commit();

    print("On Create ===================================");
  }

  //!version تابع التعديل يستدعى عندما يتغير رقم الإصدار
  _onUpgrade(Database db, int oldversion, int newversion) async {
    print("On Upgrade  ==================================");
  }

  Future<List<Map>> readDate(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertDate(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  Future<int> updateDate(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteDate(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  //!تسهيلات للتوابع (الحذف و الإضافة و التعديل والقراءة)

  Future<List<Map<String, dynamic>>> read({required String table}) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> response = await mydb!.query(
      table,
    );
    return response;
  }

  Future<int> insert({
    required String table,
    required Map<String, dynamic> values,
  }) async {
    Database? mydb = await db;
    int response = await mydb!.insert(
      table,
      values,
    );
    return response;
  }

  Future<int> update({
    required String table,
    required Map<String, dynamic> values,
    String? mywhere,
  }) async {
    Database? mydb = await db;
    int response = await mydb!.update(
      table,
      values,
      where: mywhere,
    );
    return response;
  }

  Future<int> delete({
    required String table,
    String? mywhere,
  }) async {
    Database? mydb = await db;
    int response = await mydb!.delete(
      table,
      where: mywhere,
    );
    return response;
  }
}
