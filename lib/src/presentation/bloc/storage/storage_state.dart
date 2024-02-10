part of 'storage_bloc.dart';

@immutable
sealed class StorageState {}

final class StorageInitial extends StorageState {}

// Upload One File
final class UploadFileLoading extends StorageState {}

final class UploadFileSuccess extends StorageState {
  final String downloadUrl;
  UploadFileSuccess({required this.downloadUrl});
}

final class UploadFileError extends StorageState {
  final String message;
  UploadFileError({required this.message});
}

// Upload Multiple Files
final class UploadFilesLoading extends StorageState {}

final class UploadFilesSuccess extends StorageState {}

final class UploadFilesError extends StorageState {
  final String message;
  UploadFilesError({required this.message});
}
