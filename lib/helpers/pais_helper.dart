// QUESTÃO 02

import 'package:path/path.dart';
import 'package:pdm_segunda_prova/domain/pais.dart';
import 'package:sqflite/sqflite.dart'; 

class PaisesHelper {
  static final PaisesHelper _instance = PaisesHelper.internal();

  //criação do factory para retornar a instância
  factory PaisesHelper() => _instance;

  //PaisHelper.instance
  PaisesHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "pais.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute('''
        CREATE TABLE ${Pais.paisTable}(
          ${Pais.idColuna} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${Pais.nomeColuna} TEXT,
          ${Pais.capitalColuna} TEXT,
          ${Pais.continenteColuna} TEXT,
          ${Pais.linguaColuna} TEXT,
          ${Pais.populacaoColuna} REAL,
          ${Pais.moedaColuna} TEXT
        )
      ''');
    });
  }

  Future<Pais> savePais(Pais l) async {
    Database? dbPais = await db;
    if (dbPais != null) {
      l.id = await dbPais.insert(Pais.paisTable, l.toMap());
    }
    return l;
  }

  Future<Pais?> getPais(int id) async {
    Database? dbPais = await db;
    if (dbPais != null) {
      List<Map> maps = await dbPais.query(Pais.paisTable,
          columns: [
            Pais.idColuna,
            Pais.nomeColuna,
            Pais.capitalColuna,
            Pais.continenteColuna,
            Pais.linguaColuna,
            Pais.populacaoColuna,
            Pais.moedaColuna
          ],
          where: "${Pais.idColuna} = ?",
          whereArgs: [id]);
      if (maps.length > 0)
        return Pais.fromMap(maps.first);
      else
        return null;
    }
    return null;
  }

  Future<int> deletePais(int id) async {
    Database? dbPais = await db;
    if (dbPais != null) {
      return await dbPais.delete(Pais.paisTable,
          where: "${Pais.idColuna} = ?", whereArgs: [id]);
    } else
      return 0;
  }

  Future<int> updatePais(Pais p) async {
    Database? dbPais = await db;
    if (dbPais != null) {
      return await dbPais.update(
        Pais.paisTable,
        p.toMap(),
        where: "${Pais.idColuna} = ?",
        whereArgs: [p.id],
      );
    } else {
      return 0;
    }
  }

  Future<List> getAll() async {
    Database? dbPais = await db;
    if (dbPais != null) {
      List listMap = await dbPais.query(Pais.paisTable);
      List<Pais> listPais = [];

      for (Map m in listMap) {
        listPais.add(Pais.fromMap(m));
      }
      return listPais;
    } else {
      return [];
    }
  }
}
