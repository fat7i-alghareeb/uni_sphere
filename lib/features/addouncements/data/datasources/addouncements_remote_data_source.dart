//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/addouncements_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AddouncementsRemote {
  final Dio _dio;

  const AddouncementsRemote(Dio dio) : _dio = dio;

  //* Get All Addouncements
  Future<AddouncementsModel> getAllAddouncements() {
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
