part of 'base_screen_index_bloc.dart';

@immutable
sealed class BaseScreenIndexEvent {}

class BaseScreenIndexEventChange extends BaseScreenIndexEvent {
  final int index;
  BaseScreenIndexEventChange({required this.index});
}
