import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/constants/urls.dart';
import '../../domain/entities/response_model.dart';
import '../../domain/entities/user_model/user_model.dart';
import '../../domain/entities/user_model/user_registration_req.dart';
import '../../domain/repositories/user_repository.dart';
import '../network/http_config.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<ResponseModel<UserModel?>?> registerUser(
      {required UserRegistrationReq req}) async {
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

  @override
  Future<ResponseModel<UserModel?>?> getUserByEmail(
      {required String email}) async {
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
}
