import 'package:cached_network_image/cached_network_image.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:contact_app/presentation/home/pages/details_contact_page.dart';
import 'package:contact_app/presentation/shared/extension.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactListTile extends StatelessWidget {
  final ContactEntity contact;

  const ContactListTile({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Hero(
            tag: getUniqueTag(contact),
            child: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(contact.profilePicture),
              radius: 30,
              onBackgroundImageError: (exception, stackTrace) {
                debugPrint('Error loading image: $exception');
              },
            ),
          ),
          title: Text(
            '${contact.firstName} ${contact.lastName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.verticalSpace,
              Text(contact.email),
              2.verticalSpace,
              Row(
                children: [
                  const Icon(Icons.phone, size: 16),
                  4.horizontalSpace,
                  Text(contact.phone),
                  16.horizontalSpace,
                  const Icon(Icons.phone_android, size: 16),
                  4.horizontalSpace,
                  Text(contact.cell),
                ],
              ),
            ],
          ),
          onTap: () {
            context.pushNamed(
              DetailsContactPage.routeName,
              extra: {"contatct": contact},
            );
          },
        ),
        Divider(
          thickness: 1,
          height: 1,
          color: Colors.grey.shade200,
        )
      ],
    );
  }
}
