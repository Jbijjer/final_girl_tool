const String tableGames = 'games';

class GamesFields {
  static final List<String> values = [
    /// Add all fields
    id, girlID, killerID, locationID, win, victimsSaved, victimsKilled,
    gameName, description
  ];

  static String id = '_id';
  static String girlID = 'girlID';
  static String killerID = 'killerID';
  static String locationID = 'locationID';
  static String win = 'win';
  static String victimsSaved = 'victimsSaved';
  static String victimsKilled = 'victimsKilled';
  static String gameName = 'gameName';
  static String description = 'description';
}

class Game {
  int? id;
  int girlID;
  int killerID;
  int locationID;
  bool win;
  int victimsSaved;
  int victimsKilled;
  String gameName;
  String description;

  Game({
    this.id,
    required this.girlID,
    required this.killerID,
    required this.locationID,
    required this.win,
    required this.victimsSaved,
    required this.victimsKilled,
    required this.gameName,
    required this.description,
  });

  Game copy(
          {int? id,
          int? girlID,
          int? killerID,
          int? locationID,
          bool? win,
          int? victimsSaved,
          int? victimsKilled,
          String? gameName,
          String? description}) =>
      Game(
        id: id ?? this.id,
        girlID: girlID ?? this.girlID,
        killerID: killerID ?? this.killerID,
        locationID: locationID ?? this.locationID,
        win: win ?? this.win,
        victimsSaved: victimsSaved ?? this.victimsSaved,
        victimsKilled: victimsKilled ?? this.victimsKilled,
        gameName: gameName ?? this.gameName,
        description: description ?? this.description,
      );

  static Game fromJson(Map<String, Object?> json) => Game(
        id: json[GamesFields.id] as int?,
        girlID: json[GamesFields.girlID] as int,
        killerID: json[GamesFields.killerID] as int,
        locationID: json[GamesFields.locationID] as int,
        win: json[GamesFields.win] == 1,
        victimsKilled: json[GamesFields.victimsKilled] as int,
        victimsSaved: json[GamesFields.victimsSaved] as int,
        gameName: json[GamesFields.gameName] as String,
        description: json[GamesFields.description] as String,
      );

  Map<String, Object?> toJson() => {
        GamesFields.id: id,
        GamesFields.girlID: girlID,
        GamesFields.killerID: killerID,
        GamesFields.locationID: locationID,
        GamesFields.win: win ? 1 : 0,
        GamesFields.victimsSaved: victimsSaved,
        GamesFields.victimsKilled: victimsKilled,
        GamesFields.gameName: gameName,
        GamesFields.description: description,
      };
}
