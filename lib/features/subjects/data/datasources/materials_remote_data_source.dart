//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../models/materials_model.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class MaterialsRemote {
  final Dio _dio;

  const MaterialsRemote(Dio dio) : _dio = dio;

  //* Get All Materials
  Future<MaterialsModel> getAllMaterials() {
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
