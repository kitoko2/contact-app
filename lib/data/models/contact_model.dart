import 'package:contact_app/data/models/location_model.dart';
import 'package:contact_app/data/models/login_model.dart';
import 'package:contact_app/data/models/name_model.dart';

class ContactModel {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final Login login;
  final Dob dob;
  final Registered registered;
  final String phone;
  final String cell;
  final Id id;
  final Picture picture;
  final String nat;

  ContactModel({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      gender: json['gender'],
      name: Name.fromJson(json['name']),
      location: Location.fromJson(json['location']),
      email: json['email'],
      login: Login.fromJson(json['login']),
      dob: Dob.fromJson(json['dob']),
      registered: Registered.fromJson(json['registered']),
      phone: json['phone'],
      cell: json['cell'],
      id: Id.fromJson(json['id']),
      picture: Picture.fromJson(json['picture']),
      nat: json['nat'],
    );
  }
}

class Dob {
  final String date;
  final int age;

  Dob({
    required this.date,
    required this.age,
  });

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      date: json['date'],
      age: json['age'],
    );
  }
}

class Registered {
  final String date;
  final int age;

  Registered({
    required this.date,
    required this.age,
  });

  factory Registered.fromJson(Map<String, dynamic> json) {
    return Registered(
      date: json['date'],
      age: json['age'],
    );
  }
}

class Id {
  final String name;
  final String value;

  Id({
    required this.name,
    required this.value,
  });

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'],
      value: json['value'] ?? '',
    );
  }
}

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({
    required this.large,
    required this.medium,
    required this.thumbnail,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
