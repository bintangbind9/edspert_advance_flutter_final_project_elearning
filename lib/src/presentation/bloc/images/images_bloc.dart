import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'images_event.dart';
part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  ImagesBloc() : super(ImagesInitial()) {
    on<SetImagesEvent>((event, emit) {
      emit(ImagesInitial());
      emit(ImagesDone(files: event.files));
    });

    on<PickImageEvent>((event, emit) async {
      emit(ImagesInitial());

      final XFile? file = await ImagePicker().pickImage(
        source: event.imageSource,
        imageQuality: 60,
      );

      List<XFile> files = [];
      if (file != null) files.add(file);

      emit(ImagesDone(files: files));
    });

    on<PickImagesEvent>((event, emit) async {
      emit(ImagesInitial());

      final List<XFile> files = await ImagePicker().pickMultiImage(
        imageQuality: 60,
      );

      emit(ImagesDone(files: files));
    });
  }
}
