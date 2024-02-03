import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/sign_in_google_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUsecase signInWithGoogleUsecase;

  AuthBloc({required this.signInWithGoogleUsecase}) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(SignInWithGoogleLoading());

      final user = await signInWithGoogleUsecase(null);

      if (user != null) {
        emit(SignInWithGoogleSuccess(email: user.email!));
      } else {
        emit(SignInWithGoogleError(message: 'Something went wrong.'));
      }
    });
  }
}
