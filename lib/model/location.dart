const String tableLocations = 'locations';

class LocationFields {
  static final List<String> values = [
    /// Add all fields
    id, name, isInCollection
  ];

  static String id = '_id';
  static String name = 'name';
  static String isInCollection = 'isInCollection';
}

class Location {
  int? id;
  String name;
  bool isInCollection;

  Location({
    this.id,
    required this.name,
    required this.isInCollection,
  });

  Location copy({
    int? id,
    String? name,
    bool? isInCollection,
  }) =>
      Location(
        id: id ?? this.id,
        name: name ?? this.name,
        isInCollection: isInCollection ?? this.isInCollection,
      );

  static Location fromJson(Map<String, Object?> json) => Location(
        id: json[LocationFields.id] as int?,
        name: json[LocationFields.name] as String,
        isInCollection: json[LocationFields.isInCollection] == 1,
      );

  Map<String, Object?> toJson() => {
        LocationFields.id: id,
        LocationFields.name: name,
        LocationFields.isInCollection: isInCollection ? 1 : 0,
      };
}
