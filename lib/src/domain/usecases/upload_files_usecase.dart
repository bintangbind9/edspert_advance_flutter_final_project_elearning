import 'dart:typed_data';

import '../../common/constants/general_values.dart';
import '../../data/firebase/storage_service.dart';
import '../repositories/storage_repository.dart';
import 'usecase.dart';

class UploadFilesUsecase
    implements UseCase<Future<UploadFileResult>, UploadFilesParams> {
  final StorageRepository repository;

  UploadFilesUsecase({required this.repository});

  @override
  Future<UploadFileResult> call(UploadFilesParams params) async {
    return await repository.uploadFiles(
      files: params.files,
      storagePath: params.storagePath,
    );
  }
}

class UploadFilesParams {
  final Map<String, Uint8List> files;
  final StoragePath storagePath;

  UploadFilesParams({
    required this.files,
    required this.storagePath,
  });
}
