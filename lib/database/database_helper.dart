
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
   static Database _db;

   Future<Database> get db async{
     if(_db != null)
       return _db;
       _db = await initDb();
       return _db;
   }

   DatabaseHelper.internal();

   initDb() async {
      io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path,"main.db");
      var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
      return theDb;
   }

   void _onCreate(Database db, int version) async {
     // When creating the db, create the table
     await db.execute("CREATE TABLE User(id INTEGER AUTO_INCREMENT PRIMARY KEY, username TEXT, name TEXT, email TEXT, emp_id TEXT,position TEXT, "
         " img_url TEXT,total_point TEXT,token TEXT)");
     print("Created tables");
   }

   Future<int> saveUser(User user) async{
     var dbClient = await db;
     int res = await dbClient.insert("User", user.toMap());
     return res;
   }

   Future<int> deleteUser(User user) async {
     var dbClient = await db;
     int res = await dbClient.delete("User");
     return res;
   }

   Future<bool> isLoggedIn() async{
     var dbClient = await db;
     var res  = await dbClient.query("User");
     return res.length > 0 ? true : false;
   }
   Future<User> getUser() async{
     var dbClient = await db;
     List<Map> user = await dbClient.query("User");
     if(user.length > 0){
       return User.map(user.first);
     }
     return null;
   }
}