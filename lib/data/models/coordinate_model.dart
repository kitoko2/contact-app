class Coordinates {
  final String latitude;
  final String longitude;

  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class Timezone {
  final String offset;
  final String description;

  Timezone({
    required this.offset,
    required this.description,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      offset: json['offset'],
      description: json['description'],
    );
  }
}
