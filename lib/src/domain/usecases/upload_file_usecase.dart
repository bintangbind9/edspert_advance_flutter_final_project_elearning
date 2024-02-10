import 'dart:typed_data';

import '../../common/constants/general_values.dart';
import '../../data/firebase/storage_service.dart';
import '../repositories/storage_repository.dart';
import 'usecase.dart';

class UploadFileUsecase
    implements UseCase<Future<UploadFileResult>, UploadFileParams> {
  final StorageRepository repository;

  UploadFileUsecase({required this.repository});

  @override
  Future<UploadFileResult> call(UploadFileParams params) async {
    return await repository.uploadFile(
      fileName: params.fileName,
      fileByte: params.fileByte,
      storagePath: params.storagePath,
    );
  }
}

class UploadFileParams {
  final String fileName;
  final Uint8List fileByte;
  final StoragePath storagePath;

  UploadFileParams({
    required this.fileName,
    required this.fileByte,
    required this.storagePath,
  });
}
