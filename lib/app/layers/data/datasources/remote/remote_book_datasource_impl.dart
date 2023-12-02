import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/fixture/response.dart';
import '../../../../../core/infrastructure/network/http_client/http_client_adapter_interface.dart';
import '../../../domain/entities/book_entity.dart';
import '../../dtos/book_dto.dart';
import '../remote_book_datasource_interfaces.dart';

class RemoteBookDataSourceImpl implements IRemoteBookDataSource {
  final IHttpClientAdapter<Response> _httpClientAdapter;

  RemoteBookDataSourceImpl(
      {required IHttpClientAdapter<Response> httpClientAdapter})
      : _httpClientAdapter = httpClientAdapter;
  @override
  Future<List<BookEntity>> getBooks() async {
    await Future.delayed(const Duration(seconds: 2));
    /* final result = await _httpClientAdapter
        .get(AppApi.getBooksURl, headers: {'Content-Type': 'application/json'}); */
    /* if (result.statusCode == 200) { */
    return _parseBody(jsonEncode(MockResponse.mockResponse));
    /* } else {
      throw ServerException();
    } */
  }

  List<BookEntity> _parseBody(String body) {
    try {
      final maps = json.decode(body) as List;
      return List.generate(
          maps.length, (index) => BookDTO.fromMap(maps[index]));
    } catch (e) {
      log(e.toString());
      throw ServerException();
    }
  }
}
