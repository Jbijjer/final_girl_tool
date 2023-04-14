const String tableGirls = 'girls';

class GirlFields {
  static final List<String> values = [
    /// Add all fields
    id, name, isInCollection
  ];

  static String id = '_id';
  static String name = 'name';
  static String isInCollection = 'isInCollection';
}

class Girl {
  int? id;
  String name;
  bool isInCollection;

  Girl({
    this.id,
    required this.name,
    required this.isInCollection,
  });

  Girl copy({
    int? id,
    String? name,
    bool? isInCollection,
  }) =>
      Girl(
        id: id ?? this.id,
        name: name ?? this.name,
        isInCollection: isInCollection ?? this.isInCollection,
      );

  static Girl fromJson(Map<String, Object?> json) => Girl(
        id: json[GirlFields.id] as int?,
        name: json[GirlFields.name] as String,
        isInCollection: json[GirlFields.isInCollection] == 1,
      );

  Map<String, Object?> toJson() => {
        GirlFields.id: id,
        GirlFields.name: name,
        GirlFields.isInCollection: isInCollection ? 1 : 0,
      };
}
