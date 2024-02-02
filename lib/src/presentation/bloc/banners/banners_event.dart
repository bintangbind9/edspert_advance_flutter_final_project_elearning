part of 'banners_bloc.dart';

@immutable
sealed class BannersEvent {}

class GetBannersEvent extends BannersEvent {
  final int limit;
  GetBannersEvent({required this.limit});
}
