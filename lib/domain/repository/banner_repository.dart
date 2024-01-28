import 'package:edspert_advance_flutter_final_project_elearning/data/model/banner_model.dart';

abstract class BannerRepository {
  Future<List<Banner>> getBanners({required int limit});
}
