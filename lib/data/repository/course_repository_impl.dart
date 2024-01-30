import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edspert_advance_flutter_final_project_elearning/common/constants/urls.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/course_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/response_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/domain/repository/course_repository.dart';

import '../../common/http/http_config.dart';

class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<List<Course>> getCourses({
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

        return responseModel.data ?? [];
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
