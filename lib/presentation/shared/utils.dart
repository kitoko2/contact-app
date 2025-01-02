import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:flutter/material.dart';

String appName = "Contact App";
double appPadding = 15.0;
int contactsPerPage = 50;
int initialPage = 0;

const String montserrat = "Montserrat";
const String openSans = "OpenSans";

getUniqueTag(ContactEntity contact) {
  return 'contact_avatar_${contact.firstName}${contact.lastName}${contact.uuid}';
}

customSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
