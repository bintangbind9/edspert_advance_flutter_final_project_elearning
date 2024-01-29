import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/exercise_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/domain/repository/exercise_repository.dart';

import '../../common/constants/urls.dart';
import '../../common/http/http_config.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  @override
  Future<ExerciseResponse> getExercisesByCourseIdAndEmail({
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
        ExerciseResponse exerciseResponse =
            ExerciseResponse.fromJson(response.data);
        return exerciseResponse;
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
