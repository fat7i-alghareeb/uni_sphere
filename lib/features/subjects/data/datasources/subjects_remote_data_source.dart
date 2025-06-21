//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/services/exception/error_handler.dart';
import '../models/subjects_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsRemote {
  final Dio _dio;

  const SubjectsRemote(Dio dio) : _dio = dio;

  //* Get My Subjects By Year
  Future<SubjectsModel> getMySubjectsByYear(int year) {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getMySubjectsByYear,
          queryParameters: {
            'year': year,
          },
        );
        return SubjectsModel.fromMap(response.data);
      },
    );
  }

  //* Get My Subjects
  Future<SubjectsModel> getMySubjects() {
    return throwDioException(
      () async {
        final response = await _dio.get(AppUrl.getMySubjects);
        return SubjectsModel.fromMap(response.data);
      },
    );
  }

  //* Get Subject By Id
  Future<SubjectById> getSubjectById(String id) {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getSubjectById(id),
        );
        return SubjectById.fromMap(response.data);
      },
    );
  }
}
