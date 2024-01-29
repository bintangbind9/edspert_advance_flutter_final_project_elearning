import 'package:edspert_advance_flutter_final_project_elearning/data/repository/banner_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/event_banner_model.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  BannersBloc() : super(BannersInitial()) {
    on<GetBannersEvent>((event, emit) async {
      emit(BannersLoading());
      final bannerRepository = BannerRepositoryImpl();
      final banners = await bannerRepository.getBanners(limit: event.limit);
      emit(BannersSuccess(banners: banners));
    });
  }
}
