import '../entities/event_banner_model.dart';

abstract class BannerRepository {
  Future<List<EventBanner>?> getBanners({required int limit});
}
