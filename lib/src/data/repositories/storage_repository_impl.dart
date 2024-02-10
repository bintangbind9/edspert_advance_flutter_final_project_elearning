import 'dart:typed_data';

import '../../common/constants/general_values.dart';
import '../../domain/repositories/storage_repository.dart';
import '../firebase/storage_service.dart';

class StorageRepositoryImpl implements StorageRepository {
  final StorageService storageService;

  StorageRepositoryImpl({required this.storageService});

  @override
  Future<UploadFileResult> uploadFile({
    required String fileName,
    required Uint8List fileByte,
    required StoragePath storagePath,
  }) async {
    return await storageService.uploadFile(
      fileName: fileName,
      fileByte: fileByte,
      storagePath: storagePath,
    );
  }

  @override
  Future<UploadFileResult> uploadFiles({
    required Map<String, Uint8List> files,
    required StoragePath storagePath,
  }) async {
    return await storageService.uploadFiles(
      files: files,
      storagePath: storagePath,
    );
  }
}
