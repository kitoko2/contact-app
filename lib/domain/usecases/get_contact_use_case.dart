import 'package:dartz/dartz.dart';
import 'package:contact_app/core/errors/failures.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:contact_app/domain/repositories/contact_repository.dart';

class GetContactsUseCase {
  final ContactRepository repository;

  GetContactsUseCase({required this.repository});

  Future<Either<Failure, List<ContactEntity>>> call({
    int? results,
    int? page,
  }) async {
    return await repository.getContacts(
      results: results,
      page: page,
    );
  }
}
