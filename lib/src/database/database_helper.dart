import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = "NOTASBD";
  static final _versionBD = 4;
  static final _nombreTBL = "tblNotas";
  static final _nombreTBL2="tblUser";

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
      onCreate: _crearTabla,
      onUpgrade: _onUpGadre,
      

    );
  }
    Future <void> _onUpGadre(Database db,int oldVersion,int newVersion) async{
      db.execute("DROP TABLE $_nombreTBL2");
      db.execute("CREATE TABLE $_nombreTBL2(id INTEGER PRIMARY KEY,foto text(50), nombre VARCHAR(50), apellido1 VARCHAR(50), apellido2 VARCHAR(50),telefono VARCHAR(10),correo VARCHAR(50))");
    }

   Future<void>  _crearTabla(Database db, int version) async{
      await db.execute("CREATE TABLE $_nombreTBL(id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))");
      await db.execute("CREATE TABLE $_nombreTBL2(id INTEGER PRIMARY KEY,foto text(50), nombre VARCHAR(50), apellido1 VARCHAR(50), apellido2 VARCHAR(50),telefono VARCHAR(10),correo VARCHAR(50))");
    }

  Future<int>insertUser(Map<String,dynamic> row ) async {
    var conexion = await database;
   return conexion!.insert(_nombreTBL2, row); 
  }

  Future<int> updateUser(Map<String,dynamic> row) async{
    var conexion = await database;
    return conexion!.update(_nombreTBL2,row, where: 'id = ?',whereArgs: [row['id']]);
  }

  Future<int> deleteUser(int id )async{
    var conexion = await database;
    return await conexion!.delete(_nombreTBL2,where: 'id= ?',whereArgs:[id]);
  } 

  Future<List<PerfilModel>> getAllUsers()async{
    var conexion = await database;
    var result= await conexion!.query(_nombreTBL2);
    return result.map((notaMap) => PerfilModel.fromMap(notaMap)).toList();
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

  Future<List<NotasModel>> getAllNotes()async{
    var conexion = await database;
    var result= await conexion!.query(_nombreTBL);
    return result.map((notaMap) => NotasModel.fromMap(notaMap)).toList();
  }

  Future<NotasModel> getNote(int id) async{
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL,where:'id=?',whereArgs:[id]);
    return result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
  }

}