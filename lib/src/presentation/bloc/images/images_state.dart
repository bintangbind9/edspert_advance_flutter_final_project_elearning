part of 'images_bloc.dart';

@immutable
sealed class ImagesState {}

final class ImagesInitial extends ImagesState {}

final class ImagesDone extends ImagesState {
  final List<XFile> files;
  ImagesDone({required this.files});
}
