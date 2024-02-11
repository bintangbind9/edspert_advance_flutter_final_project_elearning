import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/is_user_signed_in_usecase.dart';
import '../../../domain/usecases/sign_in_google_usecase.dart';
import '../../../domain/usecases/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUsecase signInWithGoogleUsecase;
  final SignOutUsecase signOutUsecase;
  final IsUserSignedInUsecase isUserSignedInUsecase;

  AuthBloc({
    required this.signInWithGoogleUsecase,
    required this.signOutUsecase,
    required this.isUserSignedInUsecase,
  }) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(SignInWithGoogleLoading());

      final user = await signInWithGoogleUsecase(null);

      if (user != null) {
        emit(SignInWithGoogleSuccess(email: user.email!));
      } else {
        emit(SignInWithGoogleError(message: 'Something went wrong.'));
      }
    });

    on<SignOutEvent>((event, emit) async {
      emit(AuthInitial());
      emit(SignOutLoading());

      final isLogout = await signOutUsecase.call(null);

      if (isLogout) {
        emit(SignOutSuccess());
      } else {
        emit(SignOutError(message: 'Failed Sign Out! Something went wrong.'));
      }
    });

    on<IsUserSignedInEvent>((event, emit) {
      emit(IsUserSignedInLoading());

      final isUserSignedIn = isUserSignedInUsecase.call(null);

      if (isUserSignedIn) {
        emit(IsUserSignedInTrue());
      } else {
        emit(IsUserSignedInFalse());
      }
    });
  }
}
