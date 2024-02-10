import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../common/constants/general_values.dart';

class UploadFileResult {
  final bool isSuccess;
  final String message;
  String? downloadUrl;

  UploadFileResult({
    required this.isSuccess,
    required this.message,
    this.downloadUrl,
  });
}

class StorageService {
  Future<UploadFileResult> uploadFile({
    required String fileName,
    required Uint8List fileByte,
    required StoragePath storagePath,
  }) async {
    try {
      final path = GeneralValues.storagePath.entries
          .singleWhere((e) => e.key == storagePath);

      Reference ref = FirebaseStorage.instance
          .ref()
          .child(path.value)
          .child('${FirebaseAuth.instance.currentUser?.email}')
          .child(fileName);

      /// Upload
      await ref.putData(fileByte);

      /// Get download url
      String downloadUrl = await ref.getDownloadURL();

      return UploadFileResult(
        isSuccess: true,
        message: 'success',
        downloadUrl: downloadUrl,
      );
    } catch (e) {
      String message = 'Err uploadFile: $e';

      debugPrint(message);
      return UploadFileResult(
        isSuccess: false,
        message: message,
      );
    }
  }

  Future<UploadFileResult> uploadFiles({
    required Map<String, Uint8List> files,
    required StoragePath storagePath,
  }) async {
    try {
      final path = GeneralValues.storagePath.entries
          .singleWhere((e) => e.key == storagePath);

      for (final file in files.entries) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(path.value)
            .child('${FirebaseAuth.instance.currentUser?.email}')
            .child(file.key);

        /// Upload
        await ref.putData(file.value);
      }

      return UploadFileResult(
        isSuccess: true,
        message: 'success',
      );
    } catch (e) {
      String message = 'Err uploadFile: $e';

      debugPrint(message);
      return UploadFileResult(
        isSuccess: false,
        message: message,
      );
    }
  }
}
