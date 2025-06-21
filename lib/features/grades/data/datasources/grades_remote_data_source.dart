//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/services/exception/error_handler.dart';
import '../models/grades_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesRemote {
  final Dio _dio;

  const GradesRemote(Dio dio) : _dio = dio;

  //* Get My Grades
  Future<GradesModel> getMyGrades() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getMyGrades,
        );
        return GradesModel.fromJson(response.data);
      },
    );
  }
}
