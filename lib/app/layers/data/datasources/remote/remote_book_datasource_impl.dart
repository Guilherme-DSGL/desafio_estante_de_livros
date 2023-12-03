import 'package:desafio_estante_de_livros/core/errors/exceptions.dart';

import '../../../../../core/infrastructure/network/app_api.dart';
import '../../../../../core/infrastructure/network/http_client/http_client_adapter_interface.dart';
import '../../../domain/entities/book_entity.dart';
import '../../dtos/book_dto.dart';
import '../remote_book_datasource_interfaces.dart';

class RemoteBookDataSourceImpl implements IRemoteBookDataSource {
  final IHttpClientAdapter _httpClientAdapter;

  RemoteBookDataSourceImpl({required IHttpClientAdapter httpClientAdapter})
      : _httpClientAdapter = httpClientAdapter;
  @override
  Future<List<BookEntity>> getBooks() async {
    final result = await _httpClientAdapter.get<List>(AppApi.getBooksURl);
    return List.generate(
        result.length, (index) => BookDTO.fromMap(result[index]));
  }

  @override
  Future<void> downloadBook(
      {required String downloadUrl, required String pathDirectory}) async {
    await _httpClientAdapter.download(
        downloadUrl: downloadUrl,
        pathDirectory: pathDirectory,
        onError: () {
          throw ServerException();
        });
  }
}
