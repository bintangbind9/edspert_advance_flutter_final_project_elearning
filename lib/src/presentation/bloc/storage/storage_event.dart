part of 'storage_bloc.dart';

@immutable
sealed class StorageEvent {}

class UploadFileEvent extends StorageEvent {
  final UploadFileParams params;
  UploadFileEvent({required this.params});
}

class UploadFilesEvent extends StorageEvent {
  final UploadFilesParams params;
  UploadFilesEvent({required this.params});
}
