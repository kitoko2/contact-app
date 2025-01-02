import 'package:contact_app/data/models/contact_model.dart';

class ContactEntity {
  final String? uuid;
  final String profilePicture;
  final String largeProfilePicture;
  final String firstName;
  final String lastName;
  final String address;
  final double? lat;
  final double? long;

  final String email;
  final String phone;
  final String cell;

  ContactEntity({
    required this.uuid,
    required this.profilePicture,
    required this.largeProfilePicture,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.lat,
    required this.long,
    required this.email,
    required this.phone,
    required this.cell,
  });

  // Factory constructor to create Entity from Model
  factory ContactEntity.fromModel(ContactModel model) {
    return ContactEntity(
      uuid: model.login.uuid,
      largeProfilePicture: model.picture.large,
      profilePicture: model.picture.medium,
      firstName: model.name.first,
      lastName: model.name.last,
      address:
          '${model.location.street.number} ${model.location.street.name}, ${model.location.city}, ${model.location.state}, ${model.location.country}',
      lat: double.tryParse(model.location.coordinates.latitude),
      long: double.tryParse(model.location.coordinates.longitude),
      email: model.email,
      phone: model.phone,
      cell: model.cell,
    );
  }
}
