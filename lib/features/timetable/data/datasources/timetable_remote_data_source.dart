//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../models/timetable_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableRemote {
  final Dio _dio;

  const TimetableRemote(Dio dio) : _dio = dio;

  //* Get All Timetable
  Future<TimetableModel> getAllTimetable() {
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
