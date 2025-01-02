import 'package:dartz/dartz.dart';
import 'package:contact_app/core/errors/failures.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';

abstract class ContactRepository {
  /// Récupère une liste de contacts
  /// [results] : nombre de contacts à récupérer
  /// [page] : numéro de la page pour la pagination
  Future<Either<Failure, List<ContactEntity>>> getContacts({
    int? results,
    int? page,
  });
}
