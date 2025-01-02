import 'package:contact_app/core/network/api_endpoints.dart';
import 'package:contact_app/core/network/dio_helper.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/domain/entities/contact_entity.dart';
import 'package:flutter/material.dart';

abstract class ContactRemoteDataSource {
  Future<List<ContactEntity>> getContacts({int? results, int? page});
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final DioHelper dioHelper;

  ContactRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<List<ContactEntity>> getContacts({int? results, int? page}) async {
    final response = await dioHelper.get(
      endpoint: ApiEndpoints.getContact,
      queryParameters: {
        'results': results,
        'page': page,
      },
    );

    final List<dynamic> contactsJson = response.data['results'];
    final List<ContactModel> contactModels =
        contactsJson.map((json) => ContactModel.fromJson(json)).toList();

    return _convertToContactEntities(contactModels);
  }

  List<ContactEntity> _convertToContactEntities(
      List<ContactModel> contactsModels) {
    return contactsModels.map((model) {
      try {
        return ContactEntity.fromModel(model);
      } catch (e) {
        debugPrint('Error converting contact: $e');
        rethrow;
      }
    }).toList();
  }
}
