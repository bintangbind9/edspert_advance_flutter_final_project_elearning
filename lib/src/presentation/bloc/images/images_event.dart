part of 'images_bloc.dart';

@immutable
sealed class ImagesEvent {}

class SetImagesEvent extends ImagesEvent {
  final List<XFile> files;
  SetImagesEvent({required this.files});
}

class PickImageEvent extends ImagesEvent {
  final ImageSource imageSource;
  PickImageEvent({required this.imageSource});
}

class PickImagesEvent extends ImagesEvent {}
