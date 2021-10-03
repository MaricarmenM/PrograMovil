import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabasePerfil {
  static final _nombreBD = "PERFILDB";
  static final _versionBD = 2;
  static final _nombreTBL= "tblUser";

  static Database? _database;
  Future<Database?> get database async{
    if (_database != null)return _database; {
      _database = await _initDatabase();
      return _database;
    }
  }
  Future<Database> _initDatabase() async{
    Directory carpeta = await getApplicationSupportDirectory();
    String rutaBD = join(carpeta.path,_nombreBD);
    return openDatabase(
      rutaBD,
      version: _versionBD,
      onCreate:_crearTabla,
    );
  }
    //NUEVA TABLA
    Future<void> _crearTabla(Database db, int version) async{
     await db.execute("CREATE TABLE $_nombreTBL(id INTEGER PRIMARY KEY,foto VARCHAR(50), nombre VARCHAR(50), apellido1 VARCHAR(50), apellido2 VARCHAR(50),telefono VARCHAR(10),correo VARCHAR(50))");
    }
  
  Future<int>insert(Map<String,dynamic> row ) async {
    var conexion = await database;
   return conexion!.insert(_nombreTBL, row); 
  }

  Future<int> update(Map<String,dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTBL,row, where: 'id = ?',whereArgs: [row['id']]);
  }

  Future<int> delete(int id )async{
    var conexion = await database;
    return await conexion!.delete(_nombreTBL,where: 'id= ?',whereArgs:[id]);
  } 

  Future<List<PerfilModel>> getAllUsers()async{
    var conexion = await database;
    var result= await conexion!.query(_nombreTBL);
    return result.map((notaMap) => PerfilModel.fromMap(notaMap)).toList();
  }

  Future<PerfilModel> getUser(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL,where:'id=?',whereArgs:[id]);
    return result.map((notaMap) => PerfilModel.fromMap(notaMap)).first;
  }

}