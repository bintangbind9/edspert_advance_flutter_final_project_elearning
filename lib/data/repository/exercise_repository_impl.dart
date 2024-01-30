import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/exercise_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/response_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/domain/repository/exercise_repository.dart';

import '../../common/constants/urls.dart';
import '../../common/http/http_config.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  @override
  Future<ResponseModel<List<Exercise>>> getExercisesByCourseIdAndEmail({
    required String courseId,
    required String email,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().get(
        Urls.exerciseList,
        queryParameters: {
          'course_id': courseId,
          'user_email': email,
        },
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<List<Exercise>> responseModel =
            ResponseModel<List<Exercise>>.fromJson(
          json: responseJson,
          toJsonData: (data) => data.map((e) => e.toJson()),
          fromJsonData: (data) => responseJson['data'] == null
              ? []
              : List.from(data.map((e) => Exercise.fromJson(e))),
        );

        return responseModel;
      }

      throw Exception('Status Code not 200');
    } on DioException catch (e) {
      log('${e.error}: ${e.message}');
      rethrow;
    } catch (e) {
      log('${e.toString()}: Unknown Error');
      rethrow;
    }
  }
}
