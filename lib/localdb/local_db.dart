import 'package:fashion_ai/models/message.dart';
import 'package:sqflite/sqflite.dart';

class LocalDb {
  static Database? _database;
  static final LocalDb instance = LocalDb._init();

  LocalDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('financial_rag.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE financial_rag(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        query TEXT,
        answer TEXT,
        isQuestion REAL,
        timestamp TEXT
      )
    ''');
  }

  //insert Response model into db table
  Future<int> insert(Message response) async {
    final db = await instance.database;
    return await db.insert('financial_rag', response.toJson());
  }

  //get all Response models from db table
  Future<List<Message>> getAllMessages() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('financial_rag');
    var res = List.generate(maps.length, (i) {
      return Message(
        query: maps[i]['query'],
        answer: maps[i]['answer'],
        isQuestion: maps[i]['isQuestion'] == 1,
        timestamp: DateTime.parse(maps[i]['timestamp']),
      );
    });

    //sort them by timestamp
    res.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return res;
  }

  //delete all Response models from db table
  Future<void> deleteAllMessages() async {
    final db = await instance.database;
    await db.delete('financial_rag');
  }

  //delete Response model from db table
  Future<void> deleteMessage(int id) async {
    final db = await instance.database;
    await db.delete('financial_rag', where: 'id = ?', whereArgs: [id]);
  }
}
