part of 'banners_bloc.dart';

@immutable
sealed class BannersState {}

final class BannersInitial extends BannersState {}

final class BannersLoading extends BannersState {}

final class BannersSuccess extends BannersState {
  final List<EventBanner> banners;
  BannersSuccess({required this.banners});
}

final class BannersError extends BannersState {
  final String message;
  BannersError({required this.message});
}
