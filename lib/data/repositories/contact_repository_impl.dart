import 'package:dartz/dartz.dart';
import 'package:contact_app/core/errors/exceptions.dart';
import 'package:contact_app/core/errors/failures.dart';
import 'package:contact_app/core/network/connection_checker.dart';
import 'package:contact_app/data/datasources/remote/contact_remote_data_source.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:contact_app/domain/repositories/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  ContactRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<ContactEntity>>> getContacts({
    int? results,
    int? page,
  }) async {
    if (!await connectionChecker.isConnected) {
      return const Left(NetworkFailure());
    }

    try {
      final contacts = await remoteDataSource.getContacts(
        results: results,
        page: page,
      );
      return Right(contacts);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
