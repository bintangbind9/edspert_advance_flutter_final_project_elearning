import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/upload_file_usecase.dart';
import '../../../domain/usecases/upload_files_usecase.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  final UploadFileUsecase uploadFileUsecase;
  final UploadFilesUsecase uploadFilesUsecase;

  StorageBloc({
    required this.uploadFileUsecase,
    required this.uploadFilesUsecase,
  }) : super(StorageInitial()) {
    on<UploadFileEvent>((event, emit) async {
      emit(StorageInitial());
      emit(UploadFileLoading());

      final uploadFileResult = await uploadFileUsecase.call(event.params);

      if (uploadFileResult.isSuccess) {
        emit(UploadFileSuccess(downloadUrl: uploadFileResult.downloadUrl!));
      } else {
        emit(UploadFileError(message: uploadFileResult.message));
      }
    });

    on<UploadFilesEvent>((event, emit) async {
      emit(StorageInitial());
      emit(UploadFilesLoading());

      final uploadFilesResult = await uploadFilesUsecase.call(event.params);

      if (uploadFilesResult.isSuccess) {
        emit(UploadFilesSuccess());
      } else {
        emit(UploadFilesError(message: uploadFilesResult.message));
      }
    });
  }
}
