import 'dart:developer';

import 'package:dio/dio.dart';

import '../../common/constants/urls.dart';
import '../../domain/entities/event_banner_model.dart';
import '../../domain/entities/response_model.dart';
import '../../domain/repositories/banner_repository.dart';
import '../network/http_config.dart';

class BannerRepositoryImpl implements BannerRepository {
  @override
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
}
