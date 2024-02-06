import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/constants/urls.dart';
import '../../domain/entities/course_model.dart';
import '../../domain/entities/question_model/question_model.dart';
import '../../domain/entities/response_model.dart';
import '../../domain/repositories/course_repository.dart';
import '../network/http_config.dart';

class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<List<Course>?> getCourses({
    required String majorName,
    required String email,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().get(
        Urls.courseList,
        queryParameters: {
          'major_name': majorName,
          'user_email': email,
        },
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<List<Course>> responseModel =
            ResponseModel<List<Course>>.fromJson(
          json: responseJson,
          toJsonData: (data) => data.map((e) => e.toJson()),
          fromJsonData: (data) => responseJson['data'] == null
              ? []
              : List.from(data.map((e) => Course.fromJson(e))),
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

  @override
  Future<ResponseModel<List<Question>>?> getQuestions({
    required String exerciseId,
    required String email,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().post(
        Urls.exerciseQuestionsList,
        data: {
          "exercise_id": exerciseId,
          "user_email": email,
        },
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<List<Question>> responseModel =
            ResponseModel<List<Question>>.fromJson(
          json: responseJson,
          toJsonData: (data) => data.map((e) => e.toJson()),
          fromJsonData: (data) => responseJson['data'] == null
              ? []
              : List.from(data.map((e) => Question.fromJson(e))),
        );

        return responseModel;
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
