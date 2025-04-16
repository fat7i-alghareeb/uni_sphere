//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/help_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class HelpRemote {
  final Dio _dio;

  const HelpRemote(Dio dio) : _dio = dio;

  //* Get All Help
  Future<HelpModel> getAllHelp() {
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
