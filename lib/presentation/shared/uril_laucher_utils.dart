import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  /// Lance un appel téléphonique
  static Future<void> makePhoneCall(String phoneNumber) async {
    // Nettoyer le numéro de téléphone (retirer les espaces, etc.)
    final cleanedNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: cleanedNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw Exception('Impossible de lancer l\'appel : $phoneNumber');
      }
    } catch (e) {
      debugPrint('Erreur lors de l\'appel : $e');
      rethrow;
    }
  }

  /// Lance l'application email avec un nouveau message
  static Future<void> sendEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw Exception(
            'Impossible d\'ouvrir l\'application email pour : $email');
      }
    } catch (e) {
      debugPrint('Erreur lors de l\'ouverture de l\'email : $e');
      rethrow;
    }
  }

  // lance la maps

  static Future<void> launchMapsWithCoordinates(
      double latitude, double longitude) async {
    final Uri mapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    try {
      if (await canLaunchUrl(mapsUrl)) {
        await launchUrl(mapsUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Impossible de lancer Maps.';
      }
    } on ArgumentError catch (e) {
      debugPrint('Erreur d\'argument : ${e.message}');
    } on Exception catch (e) {
      debugPrint('Erreur lors du lancement de Maps : $e');
    }
  }
}
