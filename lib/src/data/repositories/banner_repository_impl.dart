import '../../domain/entities/event_banner_model.dart';
import '../../domain/repositories/banner_repository.dart';
import '../network/api_elearning.dart';

class BannerRepositoryImpl implements BannerRepository {
  final ApiElearning apiElearning;

  BannerRepositoryImpl({required this.apiElearning});

  @override
  Future<List<EventBanner>?> getBanners({required int limit}) async =>
      await apiElearning.getBanners(limit: limit);
}
