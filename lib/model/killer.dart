const String tableKillers = 'killers';

class KillerFields {
  static final List<String> values = [
    /// Add all fields
    id, name, isInCollection
  ];

  static String id = '_id';
  static String name = 'name';
  static String isInCollection = 'isInCollection';
}

class Killer {
  int? id;
  String name;
  bool isInCollection;

  Killer({
    this.id,
    required this.name,
    required this.isInCollection,
  });

  Killer copy({
    int? id,
    String? name,
    bool? isInCollection,
  }) =>
      Killer(
        id: id ?? this.id,
        name: name ?? this.name,
        isInCollection: isInCollection ?? this.isInCollection,
      );

  static Killer fromJson(Map<String, Object?> json) => Killer(
        id: json[KillerFields.id] as int?,
        name: json[KillerFields.name] as String,
        isInCollection: json[KillerFields.isInCollection] == 1,
      );

  Map<String, Object?> toJson() => {
        KillerFields.id: id,
        KillerFields.name: name,
        KillerFields.isInCollection: isInCollection ? 1 : 0,
      };
}
