import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:edspert_advance_flutter_final_project_elearning/data/model/banner_model.dart';
import 'package:edspert_advance_flutter_final_project_elearning/domain/repository/banner_repository.dart';

import '../../common/constants/urls.dart';
import '../../common/http/http_config.dart';
import '../model/response_model.dart';

class BannerRepositoryImpl implements BannerRepository {
  @override
  Future<List<Banner>> getBanners({required int limit}) async {
    try {
      final response = await HttpConfig.dioConfig().get(
        Urls.banners,
        queryParameters: {
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        ResponseModel<List<Banner>> responseModel =
            ResponseModel<List<Banner>>.fromJson(
          json: response.data,
          toJsonData: (data) => data.map((e) => e.toJson()),
          fromJsonData: (data) =>
              List.from(data).map((e) => Banner.fromJson(e)).toList(),
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
