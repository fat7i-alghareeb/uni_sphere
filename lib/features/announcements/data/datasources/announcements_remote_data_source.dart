//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/announcements_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsRemote {
  final Dio _dio;

  const AnnouncementsRemote(Dio dio) : _dio = dio;

  //* Get All Announcements
  Future<AnnouncementsModel> getAllAnnouncements() {
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
