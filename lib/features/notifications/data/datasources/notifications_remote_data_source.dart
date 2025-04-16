//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/notifications_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class NotificationsRemote {
  final Dio _dio;

  const NotificationsRemote(Dio dio) : _dio = dio;

  //* Get All Notifications
  Future<NotificationsModel> getAllNotifications() {
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
