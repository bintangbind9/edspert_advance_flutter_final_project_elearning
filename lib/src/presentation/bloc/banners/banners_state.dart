part of 'banners_bloc.dart';

@immutable
sealed class BannersState {}

final class BannersInitial extends BannersState {}

final class GetBannersLoading extends BannersState {}

final class GetBannersSuccess extends BannersState {
  final List<EventBanner> banners;
  GetBannersSuccess({required this.banners});
}

final class GetBannersError extends BannersState {
  final String message;
  GetBannersError({required this.message});
}
