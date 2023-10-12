import 'package:calculadora_imc/models/imc.dart';
import 'package:calculadora_imc/sqlite/sqlite_database.dart';

class ImcRepository {
  Future<List<Imc>> getIMC() async {
    List<Imc> imcs = [];

    var db = await SqliteDataBase().getDatabase();

    var result = await db.rawQuery('SELECT peso, altura, imc, data FROM imc');

    for (var element in result) {
      imcs.add(Imc(
        gender: element['gender'].toString(),
        height: (element['height'] as double),
        weight: (element['weight'] as double),
      ));
    }

    return imcs;
  }

  Future<void> saveToDatabase(Imc imc) async {
    var db = await SqliteDataBase().getDatabase();

    await db.rawInsert(
        'INSERT INTO imc (gender, height, weight) values (?,?,?)',
        [imc.gender, imc.height, imc.weight]);
  }

  Future<void> deleteFromDatabase(Imc imc) async {
    var db = await SqliteDataBase().getDatabase();

    await db.rawInsert(
        'UPDATE imc SET gender = ?, height = ?, weight = ?, WHERE id = ?', [
      imc.gender,
      imc.height,
      imc.weight,
    ]);
  }
}
