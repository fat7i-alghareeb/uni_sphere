//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../../core/constants/app_url.dart' show AppUrl;
import '../../../../shared/services/exception/error_handler.dart';
import '../models/home_model.dart';

//!----------------------------  The Class  -------------------------------------!//

class HomeRemote {
  final Dio _dio;

  const HomeRemote(Dio dio) : _dio = dio;

  //* Get All Home
  Future<HomeModel> getAllHome() {
    return throwDioException(
      () async {
        final response = await _dio.get(
          AppUrl.getHomePageInfo,
        );
        return HomeModel.fromJson(response.data);
      },
    );
  }
}
