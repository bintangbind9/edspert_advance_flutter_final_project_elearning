import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/constants/urls.dart';
import '../../domain/entities/exercise_model.dart';
import '../../domain/entities/response_model.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../network/http_config.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  @override
  Future<List<Exercise>?> getExercisesByCourseIdAndEmail({
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

        return responseModel.data;
      }

      return null;
    } on DioException catch (e) {
      log('${e.error}: ${e.message}');
      return null;
    } catch (e) {
      log('${e.toString()}: Unknown Error');
      return null;
    }
  }
}
