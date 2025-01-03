import 'package:cached_network_image/cached_network_image.dart';
import 'package:contact_app/core/theme/app_colors.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:contact_app/presentation/shared/extension.dart';
import 'package:contact_app/presentation/shared/uril_laucher_utils.dart';
import 'package:contact_app/presentation/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsContactPage extends StatefulWidget {
  static const String routeName = 'details_contact';

  final ContactEntity contact;

  const DetailsContactPage({super.key, required this.contact});

  @override
  State<DetailsContactPage> createState() => _DetailsContactPageState();
}

class _DetailsContactPageState extends State<DetailsContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            backgroundColor: AppColors.primarySun600,
            foregroundColor: Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${widget.contact.firstName} ${widget.contact.lastName} ',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: openSans),
              ),
              background: Stack(
                // fit: StackFit.expand,
                children: [
                  Hero(
                    tag: getUniqueTag(widget.contact),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: widget.contact.largeProfilePicture,
                      fit: BoxFit.fill,
                      errorWidget: (context, _, __) {
                        return Container(
                          color: Theme.of(context).colorScheme.primary,
                          child: const Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                  // Gradient pour assurer la lisibilité du texte
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(
                    context,
                    icon: Icons.email,
                    title: AppLocalizations.of(context)!.email,
                    content: widget.contact.email,
                    onTap: () {
                      _launchEmail(widget.contact.email);
                    },
                  ),
                  _buildInfoSection(
                    context,
                    icon: Icons.phone,
                    title: AppLocalizations.of(context)!.telephone_fixe,
                    content: widget.contact.phone,
                    onTap: () {
                      _makePhoneCall(widget.contact.phone);
                    },
                  ),
                  _buildInfoSection(
                    context,
                    icon: Icons.phone_android,
                    title: AppLocalizations.of(context)!.telephone_mobile,
                    content: widget.contact.cell,
                    onTap: () {
                      _makePhoneCall(widget.contact.cell);
                    },
                  ),
                  _buildInfoSection(
                    context,
                    icon: Icons.location_on,
                    title: AppLocalizations.of(context)!.adresse,
                    content: widget.contact.address,
                    onTap: _launchMap,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchMap() {
    final lat = widget.contact.lat;
    final long = widget.contact.long;

    if (lat == null || long == null) {
      return;
    }

    UrlLauncherUtils.launchMapsWithCoordinates(
      lat,
      long,
    );
  }

  _makePhoneCall(String phoneNumber) async {
    try {
      await UrlLauncherUtils.makePhoneCall(phoneNumber);
    } catch (e) {
      if (!mounted) {
        return;
      }
      customSnackBar(context, '$e');
    }
  }

  _launchEmail(String email) async {
    try {
      await UrlLauncherUtils.sendEmail(
        email: email,
        subject: 'Contact depuis l\'application',
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      customSnackBar(context, '$e');
    }
  }

  Widget _buildInfoSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                      ),
                      4.verticalSpace,
                      Text(
                        content,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.4),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
