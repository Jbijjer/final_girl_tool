import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_girl_tool/model/girl.dart';
import 'package:final_girl_tool/model/killer.dart';
import 'package:final_girl_tool/model/location.dart';
import 'package:final_girl_tool/model/game.dart';

class FinalGirlDatabase {
  static final FinalGirlDatabase instance = FinalGirlDatabase._init();

  static Database? _database;

  FinalGirlDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('finalgirl.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _updateDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableGirls ( 
      ${GirlFields.id} $idType, 
      ${GirlFields.name} $textType,
      ${GirlFields.isInCollection} $boolType
      );
    ''');

    await db.execute('''
    CREATE TABLE $tableKillers ( 
      ${KillerFields.id} $idType, 
      ${KillerFields.name} $textType,
      ${KillerFields.isInCollection} $boolType
      );
    ''');

    await db.execute('''
    CREATE TABLE $tableLocations ( 
      ${LocationFields.id} $idType, 
      ${LocationFields.name} $textType,
      ${LocationFields.isInCollection} $boolType
      );
    ''');

    await db.execute('''
    CREATE TABLE $tableGames ( 
      ${GamesFields.id} $idType, 
      ${GamesFields.girlID} $integerType,
      ${GamesFields.killerID} $integerType,
      ${GamesFields.locationID} $integerType,
      ${GamesFields.win} $boolType,
      ${GamesFields.victimsSaved} $integerType,
      ${GamesFields.victimsKilled} $integerType,
      ${GamesFields.gameName} $textType,
      ${GamesFields.description} $textType
      );
    ''');

    seed1();
  }

  Future<void> _updateDB(Database db, int oldVersion, int? newVersion) async {
    seed1();
  }

  Future<Girl> createGirl(Girl girl) async {
    final db = await instance.database;
    final id = await db.insert(tableGirls, girl.toJson());
    return girl.copy(id: id);
  }

  Future<Killer> createKiller(Killer killer) async {
    final db = await instance.database;
    final id = await db.insert(tableKillers, killer.toJson());
    return killer.copy(id: id);
  }

  Future<Location> createLocation(Location location) async {
    final db = await instance.database;
    final id = await db.insert(tableLocations, location.toJson());
    return location.copy(id: id);
  }

  Future<Game> createGame(Game game) async {
    final db = await instance.database;
    final id = await db.insert(tableGames, game.toJson());
    return game.copy(id: id);
  }

  Future<Girl> readGirl(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGirls,
      columns: GirlFields.values,
      where: '${GirlFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Girl.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Killer> readKiller(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableKillers,
      columns: KillerFields.values,
      where: '${KillerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Killer.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Location> readLocation(String id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableLocations,
      columns: LocationFields.values,
      where: '${LocationFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Location.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Game> readGame(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableGames,
      columns: GamesFields.values,
      where: '${GamesFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Game.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Girl>> getAllGirls() async {
    final db = await instance.database;

    final orderBy = '${GirlFields.name} ASC';
    final result = await db.query(tableGirls, orderBy: orderBy);

    return result.map((json) => Girl.fromJson(json)).toList();
  }

  Future<List<Killer>> getAllKillers() async {
    final db = await instance.database;

    final orderBy = '${KillerFields.name} ASC';
    final result = await db.query(tableKillers, orderBy: orderBy);

    return result.map((json) => Killer.fromJson(json)).toList();
  }

  Future<List<Location>> getAllLocations() async {
    final db = await instance.database;

    final orderBy = '${LocationFields.name} ASC';
    final result = await db.query(tableLocations, orderBy: orderBy);

    return result.map((json) => Location.fromJson(json)).toList();
  }

  Future<List<Game>> getAllGames() async {
    final db = await instance.database;

    final orderBy = '${GamesFields.id} ASC';
    final result = await db.query(tableGames, orderBy: orderBy);

    return result.map((json) => Game.fromJson(json)).toList();
  }

  Future<List<Girl>> getGirlsInCollection() async {
    final db = await instance.database;

    final orderBy = '${GirlFields.name} ASC';
    final result = await db.query(tableGirls,
        where: '${GirlFields.isInCollection} = ?',
        whereArgs: [1],
        orderBy: orderBy);

    return result.map((json) => Girl.fromJson(json)).toList();
  }

  Future<List<Killer>> getKillersInCollection() async {
    final db = await instance.database;

    final orderBy = '${KillerFields.name} ASC';
    final result = await db.query(tableKillers,
        where: '${KillerFields.isInCollection} = ?',
        whereArgs: [1],
        orderBy: orderBy);

    return result.map((json) => Killer.fromJson(json)).toList();
  }

  Future<List<Location>> getLocationsInCollection() async {
    final db = await instance.database;

    final orderBy = '${LocationFields.name} ASC';
    final result = await db.query(tableLocations,
        where: '${LocationFields.isInCollection} = ?',
        whereArgs: [1],
        orderBy: orderBy);

    return result.map((json) => Location.fromJson(json)).toList();
  }

  Future<int> updateGirl(Girl girl) async {
    final db = await instance.database;

    return db.update(
      tableGirls,
      girl.toJson(),
      where: '${GirlFields.id} = ?',
      whereArgs: [girl.id],
    );
  }

  Future<int> updateKiller(Killer killer) async {
    final db = await instance.database;

    return db.update(
      tableKillers,
      killer.toJson(),
      where: '${KillerFields.id} = ?',
      whereArgs: [killer.id],
    );
  }

  Future<int> updateLocation(Location location) async {
    final db = await instance.database;

    return db.update(
      tableLocations,
      location.toJson(),
      where: '${LocationFields.id} = ?',
      whereArgs: [location.id],
    );
  }

  Future<int> deletegirl(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableGirls,
      where: '${GirlFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteKiller(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableKillers,
      where: '${KillerFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteLocation(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableLocations,
      where: '${LocationFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteGame(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableGames,
      where: '${GamesFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> getGamesCount() async {
    final db = await instance.database;

    final result = await db.rawQuery('SELECT COUNT(*) FROM games');
    return Sqflite.firstIntValue(result)!;
  }

  Future<int> getGamesWonCount() async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT COUNT(*) FROM games where win = true');
    return Sqflite.firstIntValue(result)!;
  }

  Future<int> getGamesLostCount() async {
    final db = await instance.database;

    final result =
        await db.rawQuery('SELECT COUNT(*) FROM games where win = false');
    return Sqflite.firstIntValue(result)!;
  }

  Future<String> getMostPlayedGirl() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT girlID, count(*) as total FROM games group by girlID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final girlID =
        firstRow['girlID']; // Access the 'girlID' value from the first row
    return girlID.toString(); // Return the 'girlID' value as a String
  }

  Future<String> getMostPlayedKiller() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT killerID, count(*) as total FROM games group by girlID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final killerID =
        firstRow['killerID']; // Access the 'killerID' value from the first row
    return killerID.toString(); // Return the 'killerID' value as a String
  }

  Future<String> getMostPlayedLocation() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT locationID, count(*) as total FROM games group by girlID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final locationID = firstRow[
        'locationID']; // Access the 'locationID' value from the first row
    return locationID.toString(); // Return the 'locationID' value as a String
  }

  Future<String> getMostWinGirl() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT girlID, count(*) as total FROM games where win=1 group by girlID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final girlID =
        firstRow['girlID']; // Access the 'girlID' value from the first row
    return girlID.toString(); // Return the 'girlID' value as a String
  }

  Future<String> getMostWinKiller() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT killerID, count(*) as total FROM games where win=1 group by killerID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final killerID =
        firstRow['killerID']; // Access the 'killerID' value from the first row
    return killerID.toString(); // Return the 'killerID' value as a String
  }

  Future<String> getMostWinLocation() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT locationID, count(*) as total FROM games where win=1 group by locationID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final locationID = firstRow[
        'locationID']; // Access the 'locationID' value from the first row
    return locationID.toString(); // Return the 'locationID' value as a String
  }

  Future<String> getMostLostGirl() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT girlID, count(*) as total FROM games where win=0 group by girlID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final girlID =
        firstRow['girlID']; // Access the 'girlID' value from the first row
    return girlID.toString(); // Return the 'girlID' value as a String
  }

  Future<String> getMostLostKiller() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT killerID, count(*) as total FROM games where win=0 group by killerID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final killerID =
        firstRow['killerID']; // Access the 'killerID' value from the first row
    return killerID.toString(); // Return the 'killerID' value as a String
  }

  Future<String> getMostLostLocation() async {
    final db = await instance.database;

    final result = await db.rawQuery(
        'SELECT locationID, count(*) as total FROM games where win=0 group by locationID order by total desc');

    // Check if the result is not empty
    final firstRow = result.first; // Get the first row from the result
    final locationID = firstRow[
        'locationID']; // Access the 'locationID' value from the first row
    return locationID.toString(); // Return the 'locationID' value as a String
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future seed1() async {
    createGirl(Girl(name: 'Selena', isInCollection: false));
    createGirl(Girl(name: 'Alice', isInCollection: false));
    createGirl(Girl(name: 'Asami', isInCollection: false));
    createGirl(Girl(name: 'Marie', isInCollection: false));
    createGirl(Girl(name: 'Barbara', isInCollection: false));
    createGirl(Girl(name: 'Adelaide', isInCollection: false));
    createGirl(Girl(name: 'Reiko', isInCollection: false));
    createGirl(Girl(name: 'Laurie', isInCollection: false));
    createGirl(Girl(name: 'Ellen', isInCollection: false));
    createGirl(Girl(name: 'Jenette', isInCollection: false));
    createGirl(Girl(name: 'Kate', isInCollection: false));
    createGirl(Girl(name: 'Uki', isInCollection: false));
    createGirl(Girl(name: 'Ava', isInCollection: false));
    createGirl(Girl(name: 'Ginny', isInCollection: false));
    createGirl(Girl(name: 'Red', isInCollection: false));
    createGirl(Girl(name: 'Gretel', isInCollection: false));
    createGirl(Girl(name: 'Heather', isInCollection: false));
    createGirl(Girl(name: 'Veronica', isInCollection: false));
    createGirl(Girl(name: 'Nancy', isInCollection: false));
    createGirl(Girl(name: 'Sheila', isInCollection: false));
    createGirl(Girl(name: 'Layla', isInCollection: false));
    createGirl(Girl(name: 'Agnes', isInCollection: false));
    createGirl(Girl(name: 'Julia', isInCollection: false));
    createGirl(Girl(name: 'Constance', isInCollection: false));
    createGirl(Girl(name: 'Paula', isInCollection: false));

    createKiller(Killer(name: 'Necromorph', isInCollection: false));
    createKiller(Killer(name: 'The Organism', isInCollection: false));
    createKiller(Killer(name: 'The Intruders', isInCollection: false));
    createKiller(Killer(name: 'Big, Bad, Wolf', isInCollection: false));
    createKiller(Killer(name: 'Ratchet Lady', isInCollection: false));
    createKiller(Killer(name: 'Hans', isInCollection: false));
    createKiller(Killer(name: 'Poltergeist', isInCollection: false));
    createKiller(Killer(name: 'Geppetto', isInCollection: false));
    createKiller(Killer(name: 'Inkanyambo', isInCollection: false));
    createKiller(Killer(name: 'Dr. Fright', isInCollection: false));

    createLocation(Location(name: 'USCSS PATNA', isInCollection: false));
    createLocation(Location(name: 'Station 2891', isInCollection: false));
    createLocation(Location(name: 'Wingarde Cottage', isInCollection: false));
    createLocation(Location(name: 'Storybook Woods', isInCollection: false));
    createLocation(Location(name: 'Wolfe Asylum', isInCollection: false));
    createLocation(Location(name: 'Maple Lane', isInCollection: false));
    createLocation(Location(name: 'Camp Happy Trails', isInCollection: false));
    createLocation(Location(name: 'Creech Manor', isInCollection: false));
    createLocation(Location(name: 'Carnival of Blood', isInCollection: false));
    createLocation(Location(name: 'Sacred Groves', isInCollection: false));
  }
}
