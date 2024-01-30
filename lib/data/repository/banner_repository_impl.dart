import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/event_banner_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/domain/repository/banner_repository.dart';

import '../../common/constants/urls.dart';
import '../../common/http/http_config.dart';
import '../model/response_model.dart';

class BannerRepositoryImpl implements BannerRepository {
  @override
  Future<List<EventBanner>> getBanners({required int limit}) async {
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
