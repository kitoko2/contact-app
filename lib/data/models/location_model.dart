import 'package:contact_app/data/models/coordinate_model.dart';
import 'package:contact_app/data/models/street_model.dart';

class Location {
  final Street street;
  final String city;
  final String state;
  final String country;
  final dynamic postcode;
  final Coordinates coordinates;
  final Timezone timezone;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: Street.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      timezone: Timezone.fromJson(json['timezone']),
    );
  }
}
