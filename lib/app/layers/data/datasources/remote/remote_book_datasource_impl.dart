import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/infrastructure/network/app_api.dart';
import '../../../../../core/infrastructure/network/http_client/http_client_adapter_interface.dart';
import '../../../domain/entities/book_entity.dart';
import '../../dtos/book_dto.dart';
import '../remote_book_datasource_interfaces.dart';

class RemoteBookDataSourceImpl implements IRemoteBookDataSource {
  RemoteBookDataSourceImpl({required IHttpClientAdapter httpClientAdapter})
      : _httpClientAdapter = httpClientAdapter;

  final IHttpClientAdapter _httpClientAdapter;

  @override
  Future<List<BookEntity>> getBooks({required int page}) async {
    final Map<String, dynamic> result =
        await _httpClientAdapter.get('${AppApi.getBooksURl}/?page=$page');
    print(result);
    return List.generate(
      result['results'].length,
      (index) => BookDTO.fromMap(result['results'][index]),
    );
  }

  @override
  Future<void> downloadBook({
    required String downloadUrl,
    required String pathDirectory,
  }) async {
    await _httpClientAdapter.download(
      downloadUrl: downloadUrl,
      pathDirectory: pathDirectory,
      onError: () {
        throw ServerException();
      },
    );
  }
}
