//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../models/subjects_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsRemote {
  final Dio _dio;

  const SubjectsRemote(Dio dio) : _dio = dio;

  //* Get All Subjects
  Future<SubjectsModel> getAllSubjects() {
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
