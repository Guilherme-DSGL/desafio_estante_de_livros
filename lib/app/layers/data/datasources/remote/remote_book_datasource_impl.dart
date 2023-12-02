import 'dart:convert';
import 'dart:developer';

import 'package:desafio_estante_de_livros/app/layers/data/dtos/book_dto.dart';
import 'package:desafio_estante_de_livros/app/layers/domain/entities/book_entity.dart';
import 'package:desafio_estante_de_livros/core/errors/exceptions.dart';
import 'package:desafio_estante_de_livros/core/infrastructure/network/app_api.dart';
import 'package:desafio_estante_de_livros/core/infrastructure/network/http_client/http_client_adapter_interface.dart';
import 'package:http/http.dart';

import '../remote_book_datasource_interfaces.dart';

class RemoteBookDataSource implements IRemoteBookDataSource {
  final IHttpClientAdapter<Response> _httpClientAdapter;

  RemoteBookDataSource(
      {required IHttpClientAdapter<Response> httpClientAdapter})
      : _httpClientAdapter = httpClientAdapter;
  @override
  Future<List<BookEntity>> getBooks() async {
    final result = await _httpClientAdapter
        .get(AppApi.getBooksURl, headers: {'Content-Type': 'application/json'});
    if (result.statusCode == 200) {
      return _parseBody(result.body);
    } else {
      throw ServerException();
    }
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
