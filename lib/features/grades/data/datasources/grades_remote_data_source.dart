//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../models/grades_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesRemote {
  final Dio _dio;

  const GradesRemote(Dio dio) : _dio = dio;

  //* Get All Grades
  Future<GradesModel> getAllGrades() {
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
