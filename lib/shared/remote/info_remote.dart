import 'package:dio/dio.dart';
import 'package:test/shared/entities/faculty.dart' show Faculty;
import 'package:test/shared/entities/major.dart' show Major;

import '../../core/constants/app_url.dart' show AppUrl;
import '../services/exception/error_handler.dart' show throwDioException;

class InfoRemote {
  final Dio _dio;

  const InfoRemote(Dio dio) : _dio = dio;

  Future<List<Faculty>> getFaculties() {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getFaculties);
      return response.data.map((e) => Faculty.fromMap(e)).toList();
    });
  }

  Future<List<Major>> getMajors({required String facultyId}) {
    return throwDioException(() async {
      final response = await _dio.get(AppUrl.getMajors, queryParameters: {
        'facultyId': facultyId,
      });
      return response.data.map((e) => Major.fromMap(e)).toList();
    });
  }
}