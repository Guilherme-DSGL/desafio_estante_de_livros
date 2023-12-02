import 'dart:convert';

import 'package:desafio_estante_de_livros/app/layers/data/datasources/remote/remote_book_datasource_impl.dart';
import 'package:desafio_estante_de_livros/app/layers/data/datasources/remote_book_datasource_interfaces.dart';
import 'package:desafio_estante_de_livros/app/layers/domain/entities/book_entity.dart';
import 'package:desafio_estante_de_livros/core/infrastructure/network/http_client/http_client_adapter_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_book_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HttpClientAdapter>(),
])
void main() {
  group("Remote Data Source", () {
    late List<Map<String, dynamic>> response;
    late IRemoteBookDataSource remoteBookDataSource;
    late MockHttpClientAdapter mockHttpClientAdapter;
    setUpAll(() {
      mockHttpClientAdapter = MockHttpClientAdapter();
      remoteBookDataSource =
          RemoteBookDataSource(httpClientAdapter: mockHttpClientAdapter);
      response = [
        {
          "id": 1,
          "title": "The Bible of Nature",
          "author": "Oswald, Felix L.",
          "cover_url":
              "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
          "download_url": "https://www.gutenberg.org/ebooks/72134.epub3.images"
        },
      ];
    });
    test('deve chamar HttpClientAdapter', () async {
      when(mockHttpClientAdapter.get(any, headers: anyNamed("headers")))
          .thenAnswer(
        (_) async => Response(jsonEncode(response), 200, headers: {
          'content-type': 'application/json',
        }),
      );
      final result = remoteBookDataSource.getBooks();
      expect(result, isA<Future<List<BookEntity>>>());
    });
  });
}