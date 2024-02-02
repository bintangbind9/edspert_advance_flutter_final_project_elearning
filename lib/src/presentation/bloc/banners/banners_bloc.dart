import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/event_banner_model.dart';
import '../../../domain/usecases/get_banners_usecase.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  final GetBannersUsecase getBannersUsecase;

  BannersBloc({required this.getBannersUsecase}) : super(BannersInitial()) {
    on<GetBannersEvent>((event, emit) async {
      emit(GetBannersLoading());

      final List<EventBanner>? banners =
          await getBannersUsecase(GetBannersParams(limit: event.limit));

      if (banners != null) {
        emit(GetBannersSuccess(banners: banners));
      } else {
        emit(GetBannersError(message: 'Server Error.'));
      }
    });
  }
}
