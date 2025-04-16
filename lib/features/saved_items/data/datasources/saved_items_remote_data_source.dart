//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/saved_items_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SavedItemsRemote {
  final Dio _dio;

  const SavedItemsRemote(Dio dio) : _dio = dio;

  //* Get All SavedItems
  Future<SavedItemsModel> getAllSavedItems() {
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
