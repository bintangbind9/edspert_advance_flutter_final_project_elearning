import 'package:edspert_advance_flutter_final_project_elearning/data/model/event_banner_model.dart';

abstract class BannerRepository {
  Future<List<EventBanner>> getBanners({required int limit});
}
