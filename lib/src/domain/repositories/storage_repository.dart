import 'dart:typed_data';

import '../../common/constants/general_values.dart';
import '../../data/firebase/storage_service.dart';

abstract class StorageRepository {
  Future<UploadFileResult> uploadFile({
    required String fileName,
    required Uint8List fileByte,
    required StoragePath storagePath,
  });

  Future<UploadFileResult> uploadFiles({
    required Map<String, Uint8List> files,
    required StoragePath storagePath,
  });
}
