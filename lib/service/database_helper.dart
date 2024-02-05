import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fpdart/fpdart.dart';
import 'package:sqflite_crud_operation/core/failures/failure.dart';
import '../models/person_model.dart';

class DatabaseHelper {
  static const String dbName = 'person.db';
  static const int version = 1;

  static Future<Database> getDB() async {
    Database database = await openDatabase(
        join(await getDatabasesPath(), dbName),
        version: version, onCreate: (Database db, int version) async {
      await db.execute(
          "CREATE TABLE Person(id INTEGER PRIMARY KEY, name TEXT NOT NULL, email TEXT NOT NULL)");
    });

    return database;
  }

  static Future<Either<Failure, int>> addPerson(PersonModel person) async {
    Database database = await getDB();
    try {
      int value = await database.insert("Person", person.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return Right(value);
    } catch (e) {
      return Left(ServerFailure(message: "Server is failed"));
    }
  }

  static Future<Either<Failure, int>> updatePerson(PersonModel person) async {
    Database database = await getDB();
    try {
      int value = await database.update("Person", person.toJson(),
          where: 'id = ?',
          whereArgs: [person.id],
          conflictAlgorithm: ConflictAlgorithm.replace);
      return Right(value);
    } catch (e) {
      return Left(ServerFailure(message: "Server is failed"));
    }
  }

  static Future<Either<Failure, int>> deletePerson(PersonModel person) async {
    Database database = await getDB();

    try {
      int value = await database
          .delete("Person", where: 'id = ?', whereArgs: [person.id]);
      return Right(value);
    } catch (e) {
      return Left(ServerFailure(message: "Server is failed"));
    }
  }

  static Future<Either<Failure, List<PersonModel>>> getAllPerson() async {
    Database database = await getDB();

    try {
      final List<Map<String, dynamic>> maps = await database.query("Person");

      if (maps.isNotEmpty) {
        final person =
            List<PersonModel>.from(maps.map((x) => PersonModel.fromJson(x)));

        return Right(person);
      } else {
        return Left(CacheFailure(message: "No cached data found"));
      }
    } catch (e) {
      return Left(ServerFailure(message: "Server is failed"));
    }
  }
}
