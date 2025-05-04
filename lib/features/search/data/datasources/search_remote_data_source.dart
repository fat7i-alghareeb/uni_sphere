//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../models/search_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class SearchRemote {
  final Dio _dio;

  const SearchRemote(Dio dio) : _dio = dio;

  //* Get All Search
  Future<SearchModel> getAllSearch() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          "random/url",
        );
        return response.data;
      },
    );
  }
}
