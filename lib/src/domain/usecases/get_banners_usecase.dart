import '../entities/event_banner_model.dart';
import '../repositories/banner_repository.dart';
import 'usecase.dart';

class GetBannersUsecase
    implements UseCase<Future<List<EventBanner>?>, GetBannersParams> {
  final BannerRepository repository;

  GetBannersUsecase({required this.repository});

  @override
  Future<List<EventBanner>?> call(GetBannersParams params) async {
    return await repository.getBanners(limit: params.limit);
  }
}

class GetBannersParams {
  final int limit;
  GetBannersParams({required this.limit});
}
