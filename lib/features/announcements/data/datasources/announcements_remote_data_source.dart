//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/services/exception/error_handler.dart';
import '../models/announcements_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsRemote {
  final Dio _dio;

  const AnnouncementsRemote(Dio dio) : _dio = dio;

  //* Get All Announcements
  Future<AnnouncementsModel> getStudentAnnouncements() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getStudentAnnouncements,
        );
        return AnnouncementsModel.fromJson(response.data);
      },
    );
  }

  Future<AnnouncementsModel> getFacultyAnnouncements() {
    return throwDioException(
      () async {
        final response = await _dio.get(AppUrl.getFacultyAnnouncements);
        return AnnouncementsModel.fromJson(response.data);
      },
    );
  }
}
