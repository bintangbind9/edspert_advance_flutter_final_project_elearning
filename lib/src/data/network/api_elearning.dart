import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/constants/urls.dart';
import '../../domain/entities/course_model.dart';
import '../../domain/entities/event_banner_model.dart';
import '../../domain/entities/exercises/exercise_model.dart';
import '../../domain/entities/exercises/exercise_result.dart';
import '../../domain/entities/exercises/submit_exercise_answers_req.dart';
import '../../domain/entities/question_model/question_model.dart';
import '../../domain/entities/response_model.dart';
import '../../domain/entities/user_model/user_model.dart';
import '../../domain/entities/user_model/user_model_req.dart';
import 'http_config.dart';

class ApiElearning {
  Future<ResponseModel<UserModel?>?> registerUser({
    required UserModelReq req,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().post(
        Urls.userRegister,
        data: req.toJson(),
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<UserModel?> responseModel =
            ResponseModel<UserModel?>.fromJson(
          json: responseJson,
          toJsonData: (data) => data?.toJson(),
          fromJsonData: (data) =>
              responseJson['data'] == null ? null : UserModel.fromJson(data),
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

  Future<ResponseModel<UserModel?>?> getUserByEmail({
    required String email,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().get(
        Urls.users,
        queryParameters: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<UserModel?> responseModel =
            ResponseModel<UserModel?>.fromJson(
          json: responseJson,
          toJsonData: (data) => data?.toJson(),
          fromJsonData: (data) =>
              responseJson['data'] == null ? null : UserModel.fromJson(data),
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

  Future<ResponseModel<UserModel?>?> updateUser({
    required UserModelReq req,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().post(
        Urls.userUpdate,
        data: req.toJson(),
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<UserModel?> responseModel =
            ResponseModel<UserModel?>.fromJson(
          json: responseJson,
          toJsonData: (data) => data?.toJson(),
          fromJsonData: (data) =>
              responseJson['data'] == null ? null : UserModel.fromJson(data),
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

  Future<List<EventBanner>?> getBanners({required int limit}) async {
    try {
      final response = await HttpConfig.dioConfig().get(
        Urls.banners,
        queryParameters: {
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<List<EventBanner>> responseModel =
            ResponseModel<List<EventBanner>>.fromJson(
          json: responseJson,
          toJsonData: (data) => data.map((e) => e.toJson()),
          fromJsonData: (data) => responseJson['data'] == null
              ? []
              : List.from(data.map((e) => EventBanner.fromJson(e))),
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

  Future<List<Exercise>?> getExercises({
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

  Future<ResponseModel<void>?> submitExerciseAnswers({
    required SubmitExerciseAnswersReq req,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().post(
        Urls.submitExerciseAnswers,
        data: req.toJson(),
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<void> responseModel = ResponseModel<void>.fromJson(
          json: responseJson,
          toJsonData: (data) {},
          fromJsonData: (data) {},
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

  Future<ResponseModel<ExerciseResult?>?> getExerciseResult({
    required String exerciseId,
    required String email,
  }) async {
    try {
      final response = await HttpConfig.dioConfig().get(
        Urls.exerciseResult,
        queryParameters: {
          "exercise_id": exerciseId,
          "user_email": email,
        },
      );

      if (response.statusCode == 200) {
        final responseJson = response.data;

        ResponseModel<ExerciseResult?> responseModel =
            ResponseModel<ExerciseResult?>.fromJson(
          json: responseJson,
          toJsonData: (data) => data?.toJson(),
          fromJsonData: (data) => responseJson['data'] == null
              ? null
              : ExerciseResult.fromJson(data),
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
